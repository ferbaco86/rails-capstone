module ApplicationHelper
  def signed_in?
    session[:user_id] != nil
  end

  def user?
    edit_icon = content_tag(:i, nil, class: 'fas fa-user-edit')
    delete_icon = content_tag(:i, nil, class: 'fas fa-user-times')
    edit_link = link_to(edit_icon, edit_user_path(@user), class: 'article-vote',
                                                          id: 'user-edit')
    delete_link = link_to(delete_icon, user_path(@user), method: :delete, data: { confirm: 'Are you sure?' },
                                                         class: 'article-vote', id: 'user-delete')

    if session[:user_id].to_s != params[:id].to_s
      content_tag(:h3, "You're not allowed to edit this user")
    else
      edit_link + delete_link
    end
  end

  def show_vote(article)
    if signed_in?
      vote_icon = content_tag(:i, nil, class: 'far fa-thumbs-up')
      art_vote = link_to(vote_icon, article_votes_path(article_id: article.id),
                         class: 'article-vote', method: :post)
    else
      art_vote = content_tag(:i, nil, class: 'far fa-thumbs-up')
    end
    art_vote
  end

  def show_picture(article)
    rails_blob_url(article.picture) if article.picture.attached?
  end

  def menu_categories
    categories = Category.categories_priority.take(4)
    content_tag :div, class: 'd-flex j-content-evenly a-items-center f-grow-1' do
      categories.collect do |category|
        concat(link_to(category.name, articles_path(category), class: 'nav-links cat-navbar chivo-regular'))
      end
    end
  end

  def check_categories(form, article, categories, submit_text)
    if article.categories.empty?
      concat(collection_select(:category, :id, categories, :id, :name, { selected: categories.first.id }))
    else
      concat(collection_select(:category, :id, categories, :id, :name, { selected: article.categories.first.id }))
    end
    if @categories.blank?
      content_tag(:h3, 'Please add category', class: 'alert-cat')
    else
      form.submit submit_text
    end
  end

  def show_edit_icon
    return unless @article.author.id == session[:user_id]

    link_to(content_tag(:i, nil, class: 'far fa-edit'), edit_article_path(@article.id),
            class: 'article-vote')
  end

  def show_errors(model)
    return unless model.errors.any?

    concat content_tag(:div,
                       content_tag(:h2,
                                   pluralize(model.errors.count, 'error') + ' not allowed to complete the operation'),
                       id: 'error_explanation', class: 'd-flex a-items-center')

    content_tag :ul, class: 'article-vote' do
      model.errors.full_messages.each do |message|
        concat(content_tag(:li, message))
      end
    end
  end

  def logged_menu
    if signed_in?
      content_tag :div, class: 'd-flex j-content-evenly a-items-center nav-right' do
        concat content_tag(:h3, link_to(session[:name].to_s, user_path(session[:user_id]), class: 'nav-links'),
                           id: 'user-name')
        concat link_to('WRITE AN ARTICLE', new_article_path, class: 'nav-links')
        concat link_to('LOG OUT', sessions_destroy_path, class: 'nav-links')
      end
    else
      content_tag :div, class: 'd-flex a-items-center j-content-end nav-right' do
        concat link_to('LOG IN | ', sessions_log_in_path, class: 'nav-links')
        concat link_to(' REGISTER', new_user_path, class: 'nav-links')
      end
    end
  end
end
