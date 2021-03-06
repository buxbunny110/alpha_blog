class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new 
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    if @user.update(users_params)
      flash[:notice] = 'Your account information is updated'
      redirect_to @user
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