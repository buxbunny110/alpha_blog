class ArticlesController < ApplicationController
  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
  end
  # POST /articles or /articles.json
  def create
    @article = Article.new(params.require(:articles).permit(:title, :description))
    @article.save
    redirect_to @article
  end

end
