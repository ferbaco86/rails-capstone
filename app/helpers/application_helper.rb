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
        concat(content_tag(:h3, article.title ) + content_tag(:p, article.text) + (image_tag(article.picture, width: 200)if article.picture.attached?))
        tag(:br)
      end
    end
  end
end
