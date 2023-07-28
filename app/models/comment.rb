class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :text, presence: true

  after_save :increment_post_comments_counter
  after_destroy :decrement_post_comments_counter

  def increment_post_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_post_comments_counter
    post.decrement!(:comments_counter)
  end
end
