class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.all
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5).order('id DESC')
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

  def edit 
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category has been updated"
      redirect_to(categories_path)
    else
      flash[:alert] = "Can't update category" 
      render 'edit'
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