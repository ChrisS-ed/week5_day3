class ArticlesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource except: :create

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    authorize! :create, Article
    a = Article.create(article_params)
    a.update_attribute(:user_id,current_user.id)
    redirect_to(articles_path)
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
      @article = Article.find(params[:id])
      @article.update(article_params)
      redirect_to(articles_path)
  end

  private
    def article_params
      params.require(:article).permit(:title, :content)
    end

end
