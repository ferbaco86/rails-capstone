module ArticlesHelper
  def show_feature_article
    if @featured_article.blank?
      content_tag(:h3, "There's no featured article yet", class: 'articles-cat-title')
    else
      bg_img = "background: no-repeat top center/cover url( #{show_picture(@featured_article)});"
      p_text = content_tag(:div, sanitize(@featured_article.text.truncate(100)), class: "trix-content featured-art-text")
      content_tag :article, class: 'featured-article d-flex flex-column j-content-end', style: bg_img do
        concat content_tag(:div, content_tag(:h2,
                                             link_to(@featured_article.title,
                                                     article_path(@featured_article.id),
                                                     class: 'featured-article-title chivo-bold') + p_text),
                           class: 'article-content')
      end
    end
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
        article_text = content_tag(:div, sanitize(article.text.truncate_words(20)), class: 'trix-content')
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
end
