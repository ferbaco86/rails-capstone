require_relative '../rails_helper'

RSpec.describe User, type: :model do
  context 'creating user' do
    it 'name cannot be blank ' do
      expect { User.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'User can create articles' do
    let(:user) { User.create(name: 'Luke') }
    let(:article) { Article.create(title: 'Title test', text: 'Test article content', author_id: user.id) }
    it 'article have content Test article content' do
      expect(article.text).to eql('Test article content')
    end
    it 'User can vote' do
      article
      vote = user.votes.create(article_id: article.id)
      
      expect(Vote.first.article_id).to eql(article.id)
    end
  end

  context 'testing associations' do
    it 'should have many articles' do
      u = User.reflect_on_association(:articles)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many votes' do
      u = User.reflect_on_association(:votes)
      expect(u.macro).to eq(:has_many)
    end
  end

  context 'user scope' do
    let(:luke) { User.create(name: 'Luke') }

    it 'returns the user based on id' do
      luke
      expect(User.find_user(luke.id)).to include(luke)
    end

  end
end
