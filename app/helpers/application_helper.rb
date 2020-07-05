module ApplicationHelper
  def signed_in?
    session[:user_id] != nil
  end

  def is_user?
    edit_link = link_to("Edit", edit_user_path(@user))
    delete_link = link_to(" Delete",user_path(@user), method: :delete, data: {confirm: "Are you sure?"})
     
    if session[:user_id].to_s != params[:id].to_s
      content_tag(:h3, "You're not allowed to edit this user")
    else
      edit_link + delete_link
    end
  end

  def show_users(users)
    content_tag :ul do
      users.collect do |user|
        concat(content_tag(:li, link_to("#{user.name}", user_path(user.id))))
      end
    end
  end

  def show_articles(articles)
    content_tag :div do
      articles.collect do |article|
        article_author = content_tag(:strong, article.author.name)
        article_title = link_to(content_tag(:h3, article.title),article_path(article))
        article_text = content_tag(:p, article.text.truncate_words(10))
        article_picture = (image_tag(article.picture, width: 200)if article.picture.attached?)
        article_category = content_tag(:strong, article.categories.take.name)

        concat( article_title + article_text + article_picture + article_category + article_author ) +
        concat(link_to(content_tag(:span, 'Vote!'), article_votes_path(article_id: article.id),
method: :post))
        tag(:br)
      end
    end
  end

  def show_categories(categories)
    content_tag :div do
      categories.collect do |category|
        if category.articles.take != nil
          article_title = content_tag(:strong, category.articles.take.title)
          article_picture = (image_tag(category.articles.take.picture, width: 200) if category.articles.take.picture.attached?)
        end
        category_name = link_to(content_tag(:h3, category.name),articles_path(category))
        

        concat(  category_name + article_title + article_picture )
        tag(:br)
      end
    end
  end
end
