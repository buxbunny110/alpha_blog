class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params.require(:articles).permit(:title, :description))
    if @article.save
      flash[:notice] = 'Article was successfully created'
      redirect_to @article
    else 
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(params.require(:article).permit(:title, :description))
    if @article
      flash[:notice] = 'Article is updated!'
      redirect_to @article
    else
      render 'edit' 
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = 'Article is deleted'
      redirect_to articles_path
    end
  end

end
