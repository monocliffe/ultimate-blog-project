class SessionsController < ApplicationController
  def new; end

  def create
    @current_user = User.find_by(email: params[:email])
    if @current_user&.authenticate(params[:password])
      session[:user_id] = @current_user.id
      redirect_to home_path
    else
      flash[:alert] = 'Invalid email/password combination.'
      redirect_to login_path
    end
  end

  def destroy; end

  def show
    create
  end
end
