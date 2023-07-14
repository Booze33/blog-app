require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should be valid when present' do
    subject.name = 'Tom'
    expect(subject).to be_valid
  end

  it 'returns the 3 most recent posts' do
    user = subject
    5.times { |n| user.posts.create(title: "Post #{n}", text: "Content #{n}") }

    recent_posts = user.recent_posts
    expect(recent_posts.length).to eq(3)
    expect(recent_posts.first.title).to eq('Post 4')
    expect(recent_posts.last.title).to eq('Post 2')
  end
end
