class User < ApplicationRecord
  has_many :articles, foreign_key: "author_id"
  has_many :votes
end
