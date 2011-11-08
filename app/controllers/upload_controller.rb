class UploadController < ApplicationController
  require "mp3info"
  before_filter :require_login
  
  def index
     #render :file => 'app\views\upload\uploadfile.rhtml'
  end

  def uploadFile

    file_name = params[:upload]['datafile'].original_filename.to_s
    file_ext = file_name.downcase[-3,3]

    uploaded = Audio.new(:filehash=>file_name, :converted=>0, :imageprocessed=>0)
    @song = Song.new(:user=>current_user, :audio=>uploaded, :name=>file_name)
    @song.save
    
    newname=uploaded.id.to_s+"."+file_ext

    @post = DataFile.save(params[:upload],newname)

    
    
    Mp3Info.open(@post, :encoding => 'utf-8') do |mp3|
      @song.title = mp3.tag.title if !mp3.tag.title.nil?
      @song.artist = mp3.tag.artist if !mp3.tag.artist.nil?  
      @song.album = mp3.tag.album if !mp3.tag.album.nil?
      @song.duration = mp3.length if !mp3.length.nil?
    end
    
    
   

    md5sumHash = `md5sum #{@post}`
    filehash = md5sumHash[0..31]

    samefile = Audio.where(:filehash=>filehash).first

    if samefile.nil? then
      uploaded.filehash = filehash
      uploaded.save    
     else
      uploaded.delete
      @song.audio = samefile 
      @song.save
      File.delete(@post)
    end
    
    #render :text => "File has been uploaded successfully"

    redirect_to @song

  end

  

end
