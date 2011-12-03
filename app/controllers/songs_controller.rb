class SongsController < ApplicationController

  before_filter :require_login
  
  def index
    @songs = Song.all
  end
  
  def showUsersSongs
    @songs = Array.new
    @user = User.where(:id => params[:id]).first
    @user.songs.each do |song|
      @songs << song
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
     path=""
     @song = Song.where(:id=>params[:id]).first
     @user = @song.user
     @audio = @song.audio
     @audio_path = @audio.id.to_s+".mp3"
     @audioimage_path = audioimagepath(@audio)
     respond_to do |format|
       format.html
       format.js
     end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    if @song.update_attributes(params[:song]) then
      redirect_to(@song, :notice => 'Song was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = 'Song was successfully deleted.'
    redirect_to(songs_url)
  end
  
  def play
    path=""
     @song = Song.where(:id=>params[:id]).first

     @audio = @song.audio
     @audio_path = @audio.id.to_s+".mp3"
     @audioimage_path = audioimagepath(@audio)
     respond_to do |format|
       format.html
       format.js
     end
  end

  def audioimage
     @song = Song.where(:id=>params[:id]).first
     @audio = @song.audio
    render :text => audioimagepath(@audio)
  end

private

  def audioimagepath(audio)
    
    if audio.nil? || audio.imageprocessed == false
	"std_audioimage.png"
    else
	audio.id.to_s+".png"
    end
  end
end
