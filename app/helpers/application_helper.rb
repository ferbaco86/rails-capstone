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

  def show_articles(articles)
    content_tag :div, class: 'articles-container' do
      count = 0
      articles.collect do |article|
        votes_number = content_tag(:span, article.votes_count)
        art_vote = show_vote(article)
        author_name = content_tag(:strong, "by #{article.author.name}", class: 'article-author')
        article_author = content_tag(:div, author_name + art_vote + votes_number)
        article_title = content_tag(:div,
                                    link_to(content_tag(:h3, article.title),
                                            article_path(article),
                                            class: 'article-title chivo-regular'), class: 'd-flex a-items-center')
        article_text = content_tag(:p, article.text.truncate_words(20), class: 'article-summary')
        bg_style = "background: no-repeat center/cover url('#{if article.picture.attached?
                                                                rails_blob_url(article.picture)
                                                              end}');"
        article_picture = content_tag(:div, nil, style: bg_style, class: 'article-image')
        article_category = content_tag(:h3, article.categories.take.name, class: 'articles-cat-title')
        article_info = content_tag(:div,
                                   article_category + article_title + article_author + article_text,
                                   class: 'article-preview')

        if ((count / 2) % 2).zero?
          concat(content_tag(:article,
                             article_picture + article_info, class: 'd-flex'))
        else
          concat(content_tag(:article,
                             article_picture + article_info, class: 'd-flex row-reverse'))
        end
        count += 1
      end
    end
  end

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

  def check_categories(form, article, categories)
     if article.categories.empty?
       concat(collection_select(:category, :id, categories, :id, :name, { selected: categories.first.id } )  )
     else 
      concat(collection_select(:category, :id, categories, :id, :name, { selected: article.categories.first.id } ))
     end 
   if @categories.blank?
      content_tag(:h3 ,"Please add category",class: "alert-cat")
    else
    form.submit "Create Article"
    end
  end
end
