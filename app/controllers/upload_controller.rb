class UploadController < ApplicationController
  def index
     #render :file => 'app\views\upload\uploadfile.rhtml'
  end

  def uploadFile

    file_name = params[:upload]['datafile'].original_filename.to_s
    file_ext = file_name.downcase[-3,3]

    uploaded = Audio.new(:filehash=>file_name, :converted=>0, :imageprocessed=>0)
    useraudio = UserAudio.new(:user=>current_user, :audio=>uploaded, :name=>file_name)
    useraudio.save

    newname=uploaded.id.to_s+"."+file_ext

    @post = DataFile.save(params[:upload],newname)

    md5sumHash = `md5sum #{@post}`
    filehash = md5sumHash[0..31]

    samefile = Audio.where(:filehash=>filehash).first

    if samefile.nil? then
      uploaded.filehash = filehash
      uploaded.save    
     else
      uploaded.delete
      useraudio.audio = samefile 
      useraudio.save
      File.delete(@post)
    end
    
    #render :text => "File has been uploaded successfully"

    redirect_to :controller=>'player', :action => 'index', :id => useraudio.id

  end

end
