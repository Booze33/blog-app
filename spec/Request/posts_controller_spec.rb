require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe "GET index" do
    it "returns a successful response" do
      user = User.create(name: "John")
      get user_posts_path(user)
      expect(response).to be_successful
    end

    it "renders the index template" do
      user = User.create(name: "John")
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVv', bio: 'Teacher', posts_counter: 0) }
    let(:post) { Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0) }

    before do
      get user_post_path(user_id: user.id, id: post.id)
    end

    after do
      Post.destroy_all
      User.destroy_all
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it "renders the 'show' template" do
      expect(response).to render_template('show')
    end
  end
end
