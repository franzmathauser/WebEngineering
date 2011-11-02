class PlayerController < ApplicationController
  def index
     path=""
     @song = Song.where(:user_id=>current_user, :id=>params[:id]).first

     @audio = @song.audio
     @audio_path = @audio.id.to_s+".mp3"
     @audioimage_path = @audio.id.to_s+".png"
  end

  def list
    @songs = Array.new

    current_user.songs.each do |song|
      @songs << song
    end

  end

end
