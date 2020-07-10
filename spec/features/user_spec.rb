require_relative '../rails_helper'

RSpec.describe 'Webpage workflow', type: :system do
  describe 'Navigate the webpage' do
    it 'creates a new user and logs in' do
      visit new_user_path
      fill_in 'name', with: 'Frodo'
      click_on 'Register'
      sleep(3)
      expect(page).to have_content('Frodo you were succesfully created')
      sleep(3)
      click_on 'LOG OUT'
      expect(page).to have_content('See you soon')
      sleep(3)
      click_on 'LOG IN'
      fill_in 'name', with: 'Frodo'
      click_on 'Login'
      expect(page).to have_content('Welcome to the Den Frodo')
      sleep(3)
      find("#user-name").click 
      find("#user-edit").click
      sleep(3)
      expect(page).to have_content('Change your username')
      fill_in 'name', with: 'Gollum'
      click_on 'Update'
      expect(page).to have_content('User updated successfully!')
      sleep(3)
      find("#user-name").click 
      accept_alert do
        find("#user-delete").click
      end
      expect(page).to have_content('User eliminated!')
      sleep(3)
    end
  end
end
