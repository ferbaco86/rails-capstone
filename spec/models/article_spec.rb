require_relative '../rails_helper'

RSpec.describe Article, type: :model do
  context 'creating articles' do
    it 'records cannot be blank ' do
      expect { Article.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'checking article author' do
    let(:user) { User.create(name: 'Luke') }
    let(:article) { Article.create(title: 'New Title', text: 'content', author_id: user.id) }
    it 'user author is Luke' do
      expect(article.author.name).to eql('Luke')
    end
  end

  context 'testing associations' do
    it 'should have one user' do
      ar = Article.reflect_on_association(:author)
      expect(ar.macro).to eq(:belongs_to)
    end
    it 'should have many categories' do
      ar = Article.reflect_on_association(:categories)
      expect(ar.macro).to eq(:has_many)
    end
    it 'should have many votes' do
      ar = Article.reflect_on_association(:votes)
      expect(ar.macro).to eq(:has_many)
    end
  end

  context 'article scope' do
    let(:luke) { User.create(name: 'Luke') }
    let(:article_1) { Article.create(title: 'New Title', text: 'content', author_id: luke.id) }
    let(:article_2) { Article.create(title: 'Another Title', text: 'more content', author_id: luke.id) }
    let(:vote) { Vote.create(user_id: luke.id, article_id: article_1.id) }

    it 'returns the article with most votes' do
      article_1
      article_2
      expect(Article.select_featured_article).to eq(article_1)
    end
  end
end
