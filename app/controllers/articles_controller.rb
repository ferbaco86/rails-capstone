class ArticlesController < ApplicationController
  def new
    @article = Article.new
    @categories = Category.all
  end

  def index
    category = Category.find(params[:format])
    @articles = category.articles.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    user = User.find_user(session[:user_id])
    @article = user.take.articles.new(article_params)
    if @article.valid?
      @article.article_categories.build(category_id: category_params[:id]).save
      @article.save


      redirect_to(root_path)
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

    redirect_to(root_path)
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :text, :picture)
  end

  def category_params
    params.require(:category).permit(:id)
  end
end
