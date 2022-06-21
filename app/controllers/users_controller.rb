class UsersController < ApplicationController
  def new 
    @user = User.new
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    if @user.update(users_params)
      flash[:notice] = 'Your account information is updated'
      redirect_to articles_path
    else 
      render 'edit'
    end
  end

  def create
    @user = User.new(users_params)

    if @user.save
      flash[:notice] = 'Welcome to the alpha blog, you have successfully signed up'
      redirect_to articles_path
    else
      render 'new'
    end 
    
  end

  private

  def users_params
    params.require(:user).permit(:username, :email, :password)
  end
end