class PlayerController < ApplicationController
  def index
     path=""
     @audio = Audio.find(params[:id])
     @audio_path = @audio.id.to_s+".mp3"
     @audioimage_path = @audio.id.to_s+".png"
  end

  def list
    @audios = Array.new

    current_user.user_audios.each do |useraudios|
      @audios << useraudios.audio
    end

  end

end
