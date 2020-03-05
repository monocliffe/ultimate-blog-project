require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  context 'GET index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @posts' do
      post = FactoryBot.create(:post)
      get :index
      expect(assigns(:posts)).to eq([post])
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  context 'GET show' do
    it 'renders the #show view' do
      post = FactoryBot.create(:post)
      get :show, params: { id: post.id }
      expect(response).to render_template :show
    end
  end

  context 'destroy' do
    before :each do
      @post = FactoryBot.create(:post)
      session[:user_id] = @post.user.id
    end

    it 'should redirect to to index after deletion' do
      get :destroy, params: { id: @post.id }
      expect(response).to redirect_to(posts_url)
    end

    it 'should decrease kept & increase discarded' do
      expect{
        get :destroy, params: { id: @post.id }
      }.to change { Post.kept.count }.by(-1) && change { Post.discarded.count }.by(1)
    end

    it 'should show flash with undo' do
      get :destroy, params: { id: @post.id }
      expect(response).to redirect_to(posts_url)
      expect(flash[:alert]).to match(/Undo/)
    end
  end
end
