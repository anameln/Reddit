class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      log_in!(@user)
      redirect_to users_url
    else
      render :new
    end
  end

  def destroy
    log_out!

    redirect_to users_url
  end


  private

  def session_params
    params.require(:session).permit(:session_token)
  end
end
