class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  protected

  def current_user
    return unless session[:user_id]
    @current_user = User.where(id: session[:user_id]).first
  end

  def logged_in?
    @current_user.present?
  end
  helper_method :logged_in?

  def ensure_login
    return true if logged_in?
    session[:return_to] = request.fullpath
    redirect_to login_path
  end
end
