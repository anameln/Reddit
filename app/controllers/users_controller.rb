class UsersController < ApplicationController
  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_url
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])

    render :edit
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_url
    else
      render :edit
    end
  end

  def index
    @users = User.all

    render :index
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
