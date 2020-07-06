class Vote < ApplicationRecord

  validates :user_id, uniqueness: { scope: :article_id }
  belongs_to :user
  belongs_to :article, counter_cache: true
end
