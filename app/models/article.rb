class Article < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :votes, dependent: :destroy
  has_many :article_categories
  has_many :categories, through: :article_categories, dependent: :destroy
  has_one_attached :picture

  validates :title, presence: true, length: { in: 3..60 }
  validates :text, presence: true

  scope :featured_article, -> { where("votes_count").order(:desc).first }

end
