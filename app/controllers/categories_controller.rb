class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
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
end