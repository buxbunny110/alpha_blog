class CategoriesController < ApplicationController
  before_action :set_category, only: [:new]

  def index
  end

  def show  
  end

  def new 
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "#{@category.name} category has been saved"
    else
      flash[:warning] = "Some error creating category"
    end 
    redirect_to new_category_path
  end

  private 
  
  def set_category
    @category = Category.new 
  end

  def category_params
    params.require(:category).permit(:name)
  end
end