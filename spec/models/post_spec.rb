require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  subject { author.posts.build(title: 'Hello', text: 'This is my first post') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a title exceeding 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'is valid with a comments_counter greater than or equal to zero' do
    subject.comments_counter = 0
    expect(subject).to be_valid
  end

  it 'is valid with a likes_counter greater than or equal to zero' do
    subject.likes_counter = 0
    expect(subject).to be_valid
  end

  it 'increments the posts_counter of the author' do
    author = User.create(name: 'Jane Doe')
    post = Post.create(title: 'Test Post', author:)

    expect { post.increment_posts_counter }.to change { author.reload.posts_counter }.by(1)
  end

  it 'decrements the posts_counter of the author' do
    author = User.create(name: 'Jane Doe')
    post = Post.create(title: 'Test Post', author:)

    expect { post.decrement_posts_counter }.to change { author.reload.posts_counter }.by(-1)
  end

  it 'returns an empty array if there are no comments for the post' do
    subject.save

    recent_comments = subject.recent_comments

    expect(recent_comments).to eq([])
    expect(recent_comments).to be_an(Array)
    expect(recent_comments.length).to eq(0)
  end

  it 'returns the 5 most recent comments' do
    post = subject
    post.save
    10.times { |n| post.comments.create(author:, text: "Comment #{n}") }
    recent_comments = post.recent_comments
    expect(recent_comments.length).to eq(5)
    expect(recent_comments.first.text).to eq('Comment 9')
    expect(recent_comments.last.text).to eq('Comment 5')
  end
end
