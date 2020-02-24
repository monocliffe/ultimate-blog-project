require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    let(:user) do
      User.new(forename: 'first',
               surname: 'second',
               email: 'test@email.com',
               password: 'password')
    end

    it 'requires forename' do
      user.forename = nil
      expect(user).to_not be_valid
    end

    it 'requires surname' do
      user.surname = nil
      expect(user).to_not be_valid
    end

    it 'requires email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'requires password' do
      user.password = nil
      expect(user).to_not be_valid
    end

    it 'email is unique' do
      User.new(forename: 'first',
               surname: 'second',
               email: 'test@email.com',
               password: 'password').save
      user2 = User.new(forename: 'first',
                       surname: 'second',
                       email: 'test@email.com',
                       password: 'password').save
      expect(user2).to eq(false)
    end

    it 'email is valid format' do
      user.email = 'test'
      expect(user).to_not be_valid
    end

    it 'has many posts' do
      post1 = Post.new(title: 'Test1',
                       body: 'Test Body')
      post2 = Post.new(title: 'Test2',
                       body: 'Test Body')
      user.posts = [post1, post2]
      expect(user.posts).to_not be_nil
    end
  end
end
