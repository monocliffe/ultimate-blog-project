class ApplicationController < ActionController::Base

  before_action :current_user
  before_action :set_cache_buster

  protected

  def current_user
    return unless session[:user_id]
    @current_user = User.where(id: session[:user_id]).first
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
