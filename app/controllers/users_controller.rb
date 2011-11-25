class UsersController < ApplicationController
  
  before_filter :require_login, :only => [:edit, :update]
  def index
    @user = current_user;
    redirect_to @user;
  end  

  def new
    @user = User.new
    @title = "SignUp"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.nickname
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to WaveCloud"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
end
