require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'post validation' do
    it 'is invalid without title' do
      expect(FactoryBot.build(:post, title: nil).save).to be(false)
    end

    it 'is invalid without body' do
      expect(FactoryBot.build(:post, body: nil).save).to be(false)
    end

    it 'is invalid without user' do
      expect(FactoryBot.build(:post, user: nil).save).to be(false)
    end
  end
end
