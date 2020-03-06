require 'rails_helper'

RSpec.feature 'PostFlow', type: :feature do
  before :each do
    @post = FactoryBot.create(:post)
    @user = FactoryBot.create(:user)
  end

  let(:login) do
    visit '/home'
    click_link('Login')
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'Login'
  end

  context 'creation' do
    scenario 'creates a new post' do
      begin
        login
        visit '/posts'
        click_link('New Post')

        within('form') do
          fill_in 'post[title]', with: @post.title
          find('trix-editor').click.set(@post.body)

          click_button 'Create Post'
        end

        expect(page).to have_content(@post.title) && have_current_path(post_path(2))
      end
    end

    scenario 'not logged in no new post button' do
      visit '/posts'
      expect(page).to_not have_content('New Post')
    end

    scenario 'has blank error message' do
      begin
        login
        visit '/posts'
        click_link('New Post')

        within('form') do
          fill_in 'post[title]', with: ''
          find('trix-editor').click.set('')

          click_button 'Create Post'
        end

        expect(page).to have_content('blank')
      end
    end
  end

  scenario 'updating' do
    login
    visit '/posts'

    click_link('Edit')
    within('form') do
      fill_in 'post[title]', with: 'test'

      click_button 'Update Post'
    end
    expect(page).to have_selector '.success'

    visit post_path(@post)
    expect(page).to have_content('test')
  end

  scenario 'deleting' do
    login
    visit '/posts'

    expect(page).to have_content(@post.title)
    click_link('Delete')
    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_content(@post.title)
  end

  scenario 'restoring' do
    login
    visit '/posts'

    expect(page).to have_content(@post.title)
    click_link('Delete')
    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_content(@post.title)

    expect(page).to have_selector('.alert')
    click_link('Undo')

    expect(page).to have_content(@post.title)
  end
end