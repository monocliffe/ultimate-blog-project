# Users Controller
class SessionsController < ApplicationController
  def new; end

  def create
    @current_user = User.find_by(email: params[:email])
    if @current_user&.authenticate(params[:password])
      session[:user_id] = @current_user.id
      redirect_check
    else
      flash[:alert] = 'Invalid email/password combination.'
      redirect_to login_path
    end
  end

  def show
    create
  end

  def destroy
    session[:user_id] = @current_user = nil
    flash[:success] = 'Logout Successful!'
    redirect_to home_url
  end

  def redirect_check
    if session[:return_to]
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      redirect_to home_path
    end
  end
end
