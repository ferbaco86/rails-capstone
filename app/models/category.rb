class Category < ApplicationRecord
  has_many: articles through: :article_categories
end
