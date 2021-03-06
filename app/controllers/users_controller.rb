class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def following
    @following = User.find(params[:id]).following
  end

  def followers
    @followers = User.find(params[:id]).followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end

end
