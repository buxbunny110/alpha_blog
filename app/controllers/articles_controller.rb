class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :check_user_belonging, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).order('id DESC')
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'Article was successfully created'
      redirect_to @article
    else 
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article is updated!'
      redirect_to @article
    else
      render 'edit' 
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = 'Article is deleted'
      redirect_to articles_path
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def check_user_belonging
    if (@article.user != current_user) and not current_user.admin? 
      flash[:notice] = "You can only change your own articles"
      redirect_to(article_path)
    end
  end
end
