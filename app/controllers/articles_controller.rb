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

  def update
  end

  def destroy
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
