module CategoriesHelper
  def show_categories(categories)
    content_tag :div, class: 'categories-container' do
      article_title = content_tag(:h3, "There's no categories yet") if categories.nil?
      categories.collect do |category|
        if !category.articles.take.nil?
          article_title = content_tag(:h3, category.latest_articles.first.title)
          latest_picture = category.latest_articles.first.picture
          art_picture = "background: no-repeat center/cover url('#{if category.latest_articles.take.picture.attached?
                                                                     rails_blob_url(latest_picture)
                                                                   end}');"
        else
          article_title = content_tag(:h3, 'No articles for this category, GG')
          art_picture = 'background: #4e443e'
        end
        category_name = link_to(content_tag(:h3, category.name), articles_path(category), class: 'cat-link')

        concat(content_tag(:article,
                           (category_name + article_title),
                           style: art_picture, class: 'cat-article chivo-bold d-flex flex-column j-content-between'))
      end
    end
  end
end
