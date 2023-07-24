require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  let!(:user1) { User.create(name: 'User 1', posts_counter: 3) }
  let!(:user2) { User.create(name: 'User 2', posts_counter: 5) }

  before do
    visit users_path
  end

  it 'displays the username of all other users' do
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
  end

  it 'displays the profile picture for each user' do
    expect(page).to have_css("img[src*='https://user-images.githubusercontent.com/']")
  end

  it 'displays the number of posts each user has written' do
    expect(page).to have_content("Number of posts: #{user1.posts_counter}")
    expect(page).to have_content("Number of posts: #{user2.posts_counter}")
  end

  it 'redirects to the correct user show page when "View" is clicked' do
    click_link 'View', match: :first
    expect(page).to have_content(user1.name)
  end
end
