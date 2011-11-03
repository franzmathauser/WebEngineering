class SongCommentsController < ApplicationController
  before_filter :require_login

  def new 
    @song = Song.find(params[:song_id])
  end

  def create
    @song = Song.find(params[:song_id])
    params[:song_comment][:user_id] = current_user
    @songcomment = @song.song_comments.create(params[:song_comment])
    redirect_to @song
  end

end
