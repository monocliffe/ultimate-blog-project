require 'rails_helper'

RSpec.describe 'Post Management', :type => :request do
  it 'requests list of all users' do
    FactoryBot.create(:post, title: 'test title')
    get posts_url
    expect(response).to be_successful
    expect(response.body).to include('test title')
  end

  # it 'create post and redirect to post page' do
  #   PostsController.new.class.skip_before_action :ensure_login
  #
  #   get new_post_url
  #   expect(response).to render_template(:new)
  #
  #
  #   expect(response).to redirect_to(assigns(:post))
  #   follow_redirect!
  #
  #   expect(response).to render_template(:show)
  # end
end