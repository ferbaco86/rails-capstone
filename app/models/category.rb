class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories

  validates :name, presence: true, uniqueness: true, length: { in: 3..30 }
  validates :priority, presence: true

  scope :categories_priority, -> { order('priority DESC') }

  def latest_articles
    articles.order(created_at: :desc)
  end
end
