require_relative '../rails_helper'

RSpec.describe ArticleCategory, type: :model do
  context 'testing associations' do
    it 'should have one article' do
      a = ArticleCategory.reflect_on_association(:article)
      expect(a.macro).to eq(:belongs_to)
    end
    it 'should have one category' do
      a = ArticleCategory.reflect_on_association(:category)
      expect(a.macro).to eq(:belongs_to)
    end
  end
end
