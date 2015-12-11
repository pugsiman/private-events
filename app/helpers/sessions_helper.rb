module SessionsHelper
  def log_in(user)
    remember_token = User.create_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    @current_user = user
  end

  def log_out
    cookies.delete(:remember_token)
    @current_user = nil
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def current_user=(user)
    @current_user = user
  end

  def logged_in?
    current_user.present?
  end
end
