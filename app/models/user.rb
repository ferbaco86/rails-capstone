class User < ApplicationRecord
  has_many :articles, foreign_key: "author_id", dependent: :destroy
  has_many :votes

  validates :name, presence: true, uniqueness: true, length: { in: 2..50 }
end
