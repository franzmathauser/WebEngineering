class PlayerController < ApplicationController
  def index
     path=""
     @useraudio = UserAudio.where(:user_id=>current_user, :id=>params[:id]).first

     @audio = @useraudio.audio
     @audio_path = @audio.id.to_s+".mp3"
     @audioimage_path = @audio.id.to_s+".png"
  end

  def list
    @useraudios = Array.new

    current_user.user_audios.each do |useraudios|
      @useraudios << useraudios
    end

  end

end
