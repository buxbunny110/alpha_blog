class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.all
  end

  def show
  end

  def new 
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "#{@category.name} category has been saved"
      redirect_to(category_path(@category))
    else
      flash[:error] = "Some error creating category"
      render "new"
    end 
  end

  private 
  
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only admins can access this path"
      redirect_to(categories_path)
    end
  end
end