require_relative '../rails_helper'

RSpec.describe 'articles workflow', type: :system do
  describe 'add a new article' do
    before do
      Category.create(name: 'Comics', priority: 1)
      User.create(name: 'Peter')
    end
    
    it "logs in and creates an article" do
      visit root_path
      click_on 'LOG IN'
      fill_in 'name', with: 'Peter'
      click_on 'Login'
      expect(page).to have_content('Welcome to the Den Peter')
      sleep(3)
      click_link('WRITE AN ARTICLE')

      expect(page).to have_content('Write Your Article')

      fill_in('article[title]', with: 'Spiderman Comic')
      sleep(2)
      fill_in('article[text]', with: 'Cool new Spiderman Comic')
      sleep(2)
      find('form input[type="file"]').set('./spec/picture/spiderman.jpg')
      sleep(2)
      click_button('Create Article')
      sleep(2)

      expect(page).to have_content('Cool new Spiderman Comic')
    end
  end
end