require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  let!(:user) do
    @user = FactoryBot.create(:user)
  end

  scenario 'creates a new user' do
    begin
      visit '/signup'

      within('form') do
        fill_in 'user[forename]', with: @user.forename
        fill_in 'user[surname]', with: @user.surname
        fill_in 'user[email]', with: 'test@test.com'
        fill_in 'user[password]', with: @user.password
        fill_in 'user[password_confirmation]', with: @user.password

        click_button 'Submit'
      end

      expect(page).to have_current_path(home_path)
    end
  end

  scenario 'has blank & unique error messages' do
    begin
      visit '/signup'

      within('form') do
        fill_in 'user[forename]', with: @user.forename
        fill_in 'user[surname]', with: ''
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: @user.password

        click_button 'Submit'
      end

      expect(page).to have_content('taken') && have_content('blank')
    end
  end
end