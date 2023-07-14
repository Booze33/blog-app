require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'Hello', text: 'This is my first post') }
  subject { post.likes.build(author: user) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'updates the post likes counter' do
    expect { subject.save }.to change { post.reload.likes_counter }.by(1)
  end
end
