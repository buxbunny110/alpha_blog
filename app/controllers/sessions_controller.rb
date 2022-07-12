class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]

    user = User.find_by(email: email)
    if user and user.authenticate(password)
      session[:user_id] = user.id
      flash[:notice] = 'Logged in successfully'
      redirect_to user
    else
      flash.now[:alert] = 'Incorrect credentials'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end