class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories

  validates :name, presence: true
  validates :priority, presence: true
  
  scope :categories_priority, -> { order("priority DESC") }


  def latest_articles
    self.articles.order(created_at: :desc)
  end
end
