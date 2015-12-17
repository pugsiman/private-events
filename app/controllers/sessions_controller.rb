class SessionsController < ApplicationController
  def new
    return unless logged_in?
    flash[:info] = 'You are already logged in.'
    redirect_to root_url
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = 'Connected!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Wrong user/password'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
