RSpec.describe Vote, type: :model do
  context 'creating votes' do
    let(:user) { User.create(name: 'Luke') }
    let(:article) { Article.create(title: 'Title test', text: 'Test article content', author_id: user.id) }
    let(:vote) { Vote.create(user_id: user.id, article_id: article.id) }


    it 'voted article content to be Test article content' do
      expect(vote.article.text).to eql('Test article content')
    end
  end

  context 'testing associations' do
    it 'should have one user' do
      v = Vote.reflect_on_association(:user)
      expect(v.macro).to eq(:belongs_to)
    end
    it 'should have one article' do
      v = Vote.reflect_on_association(:article)
      expect(v.macro).to eq(:belongs_to)
    end
  end
end