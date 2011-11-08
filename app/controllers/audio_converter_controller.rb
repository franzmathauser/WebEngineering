class AudioConverterController < ApplicationController

  
  def convert_new_audiofiles

   directory = "app/assets/audio"
   tmp_directory = "audiotmp"

   @audios = Audio.where(:converted=>false)

   @audios.each do |result|
     #puts result.id.to_s + ", " + result.name

     orig_file = File.join directory, result.id.to_s+".mp3"
     res_file = File.join tmp_directory, "res_"+result.id.to_s+".mp3"
     dec_file = File.join tmp_directory, "dec_"+result.id.to_s+".wav"
    
     if !File.exists?(orig_file)
       result.destroy
       continue
     end

     sc = "lame "+ orig_file+" -f -m m -b 16 --resample 8 "+res_file+" && lame --decode "+res_file+" "+dec_file+ " && rm -f " + res_file

     puts sc
     
     system sc

     result.converted = true
     result.save

   end
   render :text => "converted " + @audios.length.to_s + " files."
  
  end

end
