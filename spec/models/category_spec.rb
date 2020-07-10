require_relative '../rails_helper'

RSpec.describe Category, type: :model do
  context 'creating categories' do
    it 'records cannot be blank ' do
      expect { Category.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'Creating article on a category' do
    let(:category) {Category.create(name: 'Movies', priority: 1) }
    let(:article) { category.articles.create(title: 'New Title', text: 'content', author_id: 1) }
    it 'user author is Luke' do
      expect(category.articles).to include(article)
    end
  end

  context 'testing associations' do
    it 'should have many articles' do
      c = Category.reflect_on_association(:articles)
      expect(c.macro).to eq(:has_many)
    end
    it 'should have many article_categories' do
      c = Category.reflect_on_association(:article_categories)
      expect(c.macro).to eq(:has_many)
    end
  end

  context 'categories scope' do
    let(:category_1) {Category.create(name: 'Movies', priority: 1) }
    let(:category_2) {Category.create(name: 'Games', priority: 2) }
    let(:category_3) {Category.create(name: 'TV', priority: 3) }
    let(:user) {User.create(name: "Luke")}
    let(:article_1) { category_1.articles.create!(title: 'New Title', text: 'content', author_id: user.id, created_at: '2020-07-09 20:12:12') }
    let(:article_2) { category_1.articles.create!(title: 'New Title 2', text: 'content 2', author_id: user.id, created_at: '2020-07-09 20:15:12') }


    it 'returns the category with highest priority' do
      category_1
      category_2
      category_3
      expect(Category.categories_priority.first).to eq(category_3)
    end

    it 'returns the latest created article' do
      user
      category_1 
      article_1
      article_2
      expect(category_1.latest_articles.first).to eq(article_2)
    end

  end
end