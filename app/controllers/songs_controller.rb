class SongsController < ApplicationController

  before_filter :require_login
  
  def index
    @songs = Song.all
  end
  
  # Renders the Songlist of the User with id params[:id]
  # Usually called by ajax
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

 # An ajax call of this method only renders the comments for a Song (views/songs/show.js.erb).
 # The Song id has to be in params[:id].
 # If this method is called normal (views/songs/show.html.erb) the Player will be rendered
 # as well with the given Song as source.
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
    respond_to do |format|
       format.html
       format.js
     end
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
 
 # An ajax call of this method only renders the player (views/songs/play.js.erb).
 # The Song id has to be in params[:id]. Else there is no
 # source file for the player
 # If this method is called normal (views/songs/play.html.erb) the comments of
 # the Song will be rendered as well.
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
