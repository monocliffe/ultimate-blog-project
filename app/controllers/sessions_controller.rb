class SessionsController < ApplicationController
  def new; end

  def create
    @current_user = User.find_by(email: params[:email])
    if @current_user&.authenticate(params[:password])
      session[:user_id] = @current_user.id
      redirect_to home_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render action: 'new'
    end
  end

  def destroy; end

  def show
    create
  end
end
