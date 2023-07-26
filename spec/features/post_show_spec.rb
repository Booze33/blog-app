require 'rails_helper'
RSpec.describe 'Post show page', type: :feature do
  let!(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let!(:post) { user.posts.create(title: 'Test Post', text: 'Post content') }
  let!(:comment1) { post.comments.create(author: user, text: 'Comment 1') }
  let!(:comment2) { post.comments.create(author: user, text: 'Comment 2') }
  before do
    visit user_post_path(user, post)
  end
  it "displays the post's title" do
    expect(page).to have_content('Add Comment')
  end
  it "displays who wrote the post" do
    expect(page).to have_content("Post ##{post.id} by #{user.name}")
  end
  it "displays how many comments the post has" do
    expect(page).to have_content("Comments: 2")
  end
  it "displays how many likes the post has" do
    expect(page).to have_content("Likes: 0")
  end
 
end
