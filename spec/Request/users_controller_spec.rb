require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    it 'returns a successful response' do
      user = User.create(name: 'John')
      get user_path(user)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create(name: 'John')
      get user_path(user)
      expect(response).to render_template(:show)
    end
  end
end
