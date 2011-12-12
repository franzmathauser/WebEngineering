class UsersController < ApplicationController
  
  before_filter :require_login, :only => [:edit, :update]
  def index
    @users = {}
    respond_to do |format|
      format.html
      format.js
    end
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
    respond_to do |format|
      format.html {render :partial => 'users/userList'}
      format.js
    end
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
  
  # Usually called via ajax (.js) on every keyup event in the search box for users
  # located in views/users/_index.html.erb.
  # The method filters all Users for the searchstring in params[:search]
  # User name and email is regarded.
  def filterUsers
    if(params[:search] && params[:search].length >= 1)
      @users = User.where('nickname LIKE ? OR email LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @users = {}
    end
    respond_to do |format|
      format.html {render :partial => 'users/userList'}
      format.js
    end
  end

end
