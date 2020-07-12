class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def home
    @categories = Category.categories_priority.includes(:articles).first(4)
    @featured_article = Article.select_featured_article
  end

  def index
    @categories = Category.all.includes(:articles)
  end

  def create
    @category = Category.new(category_params)
    if @category.valid?
      @category.save
      redirect_to(new_article_path)
    else
      render :new

    end
  end

  def edit
    @category = obtain_category
  end

  def update
    @category = obtain_category
    @category.update(category_params)

    redirect_to(root_path)
  end

  def destroy
    @category = obtain_category
    @category.destroy

    redirect_to(root_path)
  end

  private

  def category_params
    params.require(:category).permit(:name, :priority)
  end

  def obtain_category
    Category.find(params[:id])
  end
end
