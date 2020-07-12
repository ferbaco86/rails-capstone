class ArticlesController < ApplicationController
  def new
    @article = Article.new
    @categories = Category.all
  end

  def index
    category = Category.find(params[:format])
    @articles = category.latest_articles.includes(article_categories: :article)
  end

  def show
    @article = obtain_article
  end

  def create
    user = User.find_user(session[:user_id])
    @article = user.take.articles.new(article_params)
    if @article.valid?
      @article.article_categories.build(category_id: category_params[:id]).save
      @article.save

      redirect_to @article, notice: 'Article created!'
    else

      redirect_to new_article_path, alert: @article.errors.full_messages.to_s
    end
  end

  def edit
    @article = obtain_article
    redirect_to @article, notice: "You can't edit this" if restrict_article_access
    @categories = Category.all
  end

  def update
    @article = obtain_article
    @article.update(article_params)
    @article.article_categories.update(category_id: category_params[:id])

    redirect_to @article, notice: 'Article Updated!'
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

  def obtain_article
    Article.find(params[:id])
  end

  def restrict_article_access
    user_id = obtain_article.author_id
    true if session[:user_id] != user_id
  end
end
