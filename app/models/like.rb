class Like < ActiveRecord::Base
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  def update_post_likes_counter
    post.update(likes_count: post.likes.count)
  end
end
