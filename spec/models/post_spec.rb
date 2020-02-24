require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validation' do
    let(:post) do
      Post.new(title: 'Test',
               body: 'Test Body')
    end

    it 'requires title' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'requires body' do
      post.body = nil
      expect(post).to_not be_valid
    end

    it 'belongs to user' do
      post.user_id = nil
      expect(post).to_not be_valid
    end
  end
end
