class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "SignUp"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.nickname
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to WaveCloud"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
end
