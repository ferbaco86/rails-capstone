class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def index
    @articles = Article.all
  end

  def show
  end

  def create
    user = User.find_user(session[:user_id])
    @article = user.take.articles.new(article_params)
    if @article.valid?
      @article.save

      redirect_to(articles_path)
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    redirect_to(root_path)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to(articles_path)
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :text, :picture)
  end
end
