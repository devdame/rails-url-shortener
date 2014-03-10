class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You did it, dude!  Your account frakking exists"
      session[:user_id] = @user.id
    else
      flash[:notice] = "Naw, dude, naw.  You failed and are clearly a cylon"
    end
    redirect_to('/')
  end

  def logout
    redirect_to("/")
    session[:user_id] = nil
  end

  def login
    @user = User.where(username: params[:username]).first
    if @user and @user.authenticate(params[:password])
      session[:user_id] = @user.id
    else
      flash[:notice] = "Wrong login info"
    end
    redirect_to '/'
  end

  private

  def user_params
    params[:user].permit(:username, :password, :password_confirmation)
  end

end
