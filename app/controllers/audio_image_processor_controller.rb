class AudioImageProcessorController < ApplicationController
  require 'RMagick'
  
  def image_processor
    @audios = Audio.where(:imageprocessed=>false)

    @audios.each do |result|
       @audio = result
	generate_image
    end

    render :text=>"processed " + @audios.length.to_s + " images"
  end


  def generate_image

   @accuracy=50
   @width=650
   @height=100

   gc = Magick::Draw.new
   gc.stroke('#efefef')

    file = File.new('public/data/dec_'+@audio.id.to_s+".wav","r")
    @header = []
    @header[0] = file.read(4)
    @header[1] = file.read(4).unpack('H*').first
    @header[2] = file.read(4)
    @header[3] = file.read(4)
    @header[4] = file.read(4).unpack('H*').first
    @header[5] = file.read(2).unpack('H*').first
    @header[6] = file.read(2).unpack('H*').first #channels
    @header[7] = file.read(4).unpack('H*').first
    @header[8] = file.read(4).unpack('H*').first
    @header[9] = file.read(2).unpack('H*').first
    @header[10] = file.read(2).unpack('H*').first #bits/sample
    @header[11] = file.read(4)
    @header[12] = file.read(4).unpack('H*').first

    # error if @header[6] is not '0100'

    if @header[6] != '0100'
      puts "ERROR: can't create image. It's not a PCM Audio file"
    end


    
    @peek = @header[10][0..1].hex.to_i
    @byte = @peek / 8
    @channel = @header[6][0..1].hex.to_i

    # point = one data point (pixel), WIDTH * ZOOM total
    # block = one block, there are accuracy blocks per point
    # chunk = one data point 8 or 16 bit, mono or stereo
    
    @filesize  = file.size
    @chunksize = (@byte * @channel).to_i;

    @file_chunks = (@filesize - 44) / @chunksize;

    if @file_chunks < @width 
      puts "ERROR: wave file has $file_chunks chunks, "+@width+" required."
    end
    if (@file_chunks < @width*@accuracy) 
      @accuracy = 1
    end

    @point_chunks = (@file_chunks.to_f/ @width);
    @block_chunks = @file_chunks.to_f / (@width*@accuracy);

    @blocks = Array.new
    @points = 0 
    @current_file_position = 44.0
    file.seek(44, IO::SEEK_SET) 

    while !file.eof?
       # The next file position is the float value rounded to the closest chunk
        # Read the next block, take the first value (of the first channel)

        @real_pos_diff = (@current_file_position-44).to_i.modulo(@chunksize.to_i)

        if @real_pos_diff > (@chunksize/2)
          @real_pos_diff -= @chunksize
        end

	file.seek((@current_file_position - @real_pos_diff).to_i, IO::SEEK_SET) 
        @chunk = file.read(@chunksize)
        break if file.eof? && @chunk.nil? 

        @current_file_position += @block_chunks * @chunksize;

        if (@byte == 1) 
            @blocks.push(@chunk[0].unpack('C')[0])     # 8 bit
        else
            @blocks.push(@chunk[1].unpack('C')[0]^128) # 16 bit
        end

        if (@blocks.length >= @accuracy)
           # Calculate the mean and add the peak value to the array of blocks
          @blocks = @blocks.sort

          @mean = (@blocks.length.modulo(2)) ? @blocks[(@blocks.length-1) / 2]
                                         : (@blocks[@blocks.length / 2] + @blocks[@blocks.length / 2 - 1]) / 2


          if (@mean.to_i > 127) 
            @point = @blocks.pop
          else 
            @point = @blocks.shift
          end


          # Draw 
          @lineheight = (@point / 255.0 * @height).round;



         #gc.line(@points,0+(@height - @lineheight),@points,@height-(@height-@lineheight))

         if (@mean.to_i > 127)
           gc.line(@points,0,@points,0+(@height - @lineheight)-1)
           gc.line(@points,@height,@points,0+@height-(@height-@lineheight)+1)
         else
           gc.line(@points,0,@points,0+@height-(@height-@lineheight)+1)
           gc.line(@points,@height,@points,0+(@height - @lineheight)-1)
         end

         # update vars
           @points = @points +1
           @blocks = Array.new
        end

    end

    file.close
    
    images_path = "app/assets/audioimages"
    file_name = @audio.id.to_s+".png"
    file_path = images_path + "/"+ file_name

    File.delete file_path if File.exists? file_path


    img = Magick::Image.new(@width,@height) do
      self.background_color = 'transparent'
    end

    thumb = img
    
    gc.draw(img)

    @path = file_name
    
    img.write file_path

    @audio.imageprocessed = 1
    @audio.save

    @audio_path = @audio.id.to_s+'.mp3'
    

  end

end
