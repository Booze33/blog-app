require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'Hello', text: 'This is my first post') }
  subject { post.comments.build(author: user, text: 'This is a comment') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'updates the post comments counter' do
    expect { subject.save }.to change { post.reload.comments_counter }.by(1)
  end
end
