class Article < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :votes, dependent: :destroy
  has_many :article_categories
  has_many :categories, through: :article_categories, dependent: :destroy

  validates :title, presence: true, length: { in: 3..60 }
  validates :text, presence: true

end
