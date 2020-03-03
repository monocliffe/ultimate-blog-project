require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'create account' do

    it 'saves successfully' do
      expect { user_create }.to change(User, :count).by(1)
    end

    it 'redirects to homepage' do
      user_create
      expect(response).to redirect_to(home_path)
    end

    it 'logs user in' do
      user_create
      expect(session[:user_id]).to_not be_nil
    end
  end

  def user_create
    post :create, params: { user: { forename: 'Test', surname: 'false', email: 'email@email.com', password: 'pass' } }
  end
end
