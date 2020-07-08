class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def index
    @categories = Category.categories_priority.includes(:articles)
    @featured_article = Article.featured_article
  end

  def create
    @category = Category.new(category_params)
    if @category.isvalid?
      @category.save

      redirect_to(root_path)
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
    params.require(:categories).permit(:name, :priority)
  end

  def obtain_category
    Category.find(params[:id])
  end
end
