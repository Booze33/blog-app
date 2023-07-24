# spec/features/post_index_spec.rb

require 'rails_helper'

RSpec.describe 'User post index page', type: :feature do
  let!(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let!(:posts) do
    (1..10).map do |i|
      user.posts.create(title: "Post #{i}", text: "Post #{i} content")
    end
  end

  before do
    visit user_posts_path(user)
  end

  it "displays the user's profile picture" do
    expect(page).to have_css("img[src*='https://user-images.githubusercontent.com/']")
  end

  it "displays the user's username" do
    expect(page).to have_content(user.name)
  end

  it "displays the number of posts the user has written" do
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  it "displays a post's title and some of the post's body" do
    posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text.truncate(50))
    end
  end

  it "displays the first comments on a post and how many comments it has" do
    posts.each do |post|
      expect(page).to have_content("Comments: #{post.comments.count}")
      post.comments.each do |comment| # Change from post.comments.recent to post.comments
        expect(page).to have_content(comment.author.name)
        expect(page).to have_content(comment.text)
      end
    end
  end

  it "displays how many likes a post has" do
    posts.each do |post|
      expect(page).to have_content("Likes: #{post.likes_counter}")
    end
  end

  it "redirects to a post's show page when clicking on a post" do
    click_link "View", href: user_post_path(user, posts.first)
    expect(page).to have_content('Add Comment')
  end
end
