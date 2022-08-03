class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new 
    @user = User.new
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit 
  end

  def update 
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

  def destroy 
    @user.destroy
    flash[:notice] = "#{@user.username} account is deleted"
    redirect_to(users_path)
  end

  private

  def users_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user 
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user and not current_user.admin?
      flash[:alert] = "You can only edit your own account"
      redirect_to users_path
    end
  end
end