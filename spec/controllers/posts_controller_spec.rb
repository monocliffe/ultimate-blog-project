require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before :each do
    @post = FactoryBot.create(:post)
    session[:user_id] = @post.user.id
  end

  context 'index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @posts' do
      get :index
      expect(assigns(:posts)).to eq([@post])
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  context 'show' do
    it 'renders the #show view' do
      get :show, params: { id: @post.id }
      expect(response).to render_template :show
    end
  end

  context 'destroy' do
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

    it 'should restore posts' do
      get :destroy, params: { id: @post.id }
      expect{
        get :restore, params: { id: @post.id }
      }.to change { Post.kept.count }.by(1)
    end
  end

  context 'update' do
    before :each do
      get :update, params: { :id => @post.id, :post => { :title => 'test', :body => 'new body' } }
    end

    it 'should update content' do
      @post.reload
      expect(@post.title).to eq('test')
      expect(@post.body.to_s).to include('new body')
    end

    it 'should redirect to posts_url' do
      expect(response).to redirect_to(posts_url)
    end

    it 'should display success flash banner' do
      expect(flash[:success]).to match(/Post updated successfully!/)
    end
  end
end
