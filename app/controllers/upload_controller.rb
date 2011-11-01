class UploadController < ApplicationController
  def index
     #render :file => 'app\views\upload\uploadfile.rhtml'
  end

  def uploadFile

    file_name = params[:upload]['datafile'].original_filename.to_s
    file_ext = file_name.downcase[-3,3]

    puts "file_ext: " + file_ext

    uploaded = Audio.new(:filehash=>file_name, :converted=>0, :imageprocessed=>0)

    useraudio = UserAudio.new(:user=>current_user, :audio=>uploaded, :name=>file_name)

    useraudio.save

    newname=uploaded.id.to_s+"."+file_ext

    @post = DataFile.save(params[:upload],newname)
    
    
#    render :text => "File has been uploaded successfully"

    redirect_to :controller=>'player', :action => 'index', :id => uploaded.id

  end
end
