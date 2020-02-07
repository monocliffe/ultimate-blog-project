class SessionsController < ApplicationController
  def new; end

  def create
    @current_user = User.find_by(email: params[:email])
    if @current_user&.authenticate(params[:password])
      session[:user_id] = @current_user.id
      redirect_to home_path
    else
      render action: 'new'
    end
  end

  def destroy
    session[:user_id] = @current_user = nil
    flash[:success] = 'Logout Successful!'
    redirect_to home_url
  end
end
