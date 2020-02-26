require 'rails_helper'

RSpec.feature 'UserFlow', type: :feature do
  before :each do
    @user = FactoryBot.create(:user)
  end

  context 'creation' do
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

  context 'login/logout' do
    scenario 'can login via button' do
      visit '/home'

      click_link('Login')
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_button 'Login'

      expect(page).to have_content(@user.forename) && have_current_path(home_path)
    end

    scenario 'can login via restricted page request' do
      visit '/users'

      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_button 'Login'

      expect(page).to have_content(@user.forename) && have_current_path(users_path)
    end

    scenario 'can logout via button' do
      visit '/home'

      click_link('Login')
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_button 'Login'

      click_link('Logout')

      expect(page).to have_content('Login') && have_current_path(home_path)
    end

    scenario 'login error message' do
      visit '/login'

      fill_in 'email', with: ''
      fill_in 'password', with: ''
      click_button 'Login'

      expect(page).to have_selector '.alert', text: 'Invalid email/password combination.'
    end
  end
end
