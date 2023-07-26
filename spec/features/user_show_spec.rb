require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let!(:user) { User.create(name: 'John Doe', posts_counter: 0, bio: 'Sample bio') }
  let!(:posts) do
    (1..5).map do |i|
      user.posts.create(title: "Post #{i}", text: "Post #{i} content")
    end
  end

  before do
    visit user_path(user)
  end

  it "displays the user's profile picture" do
    expect(page).to have_css("img[src*='https://user-images.githubusercontent.com/']")
  end

  it "displays the user's username" do
    expect(page).to have_content(user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  it "displays the user's bio" do
    expect(page).to have_content(user.bio)
  end

  it "displays the user's first 3 posts" do
    user.posts.limit(3).each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it "displays a button to view all of the user's posts" do
    expect(page).to have_link('Posts', href: user_posts_path(user))
  end

  it "redirects to the user's post index page when clicking 'Posts'" do
    click_link 'Posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
