class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :increment_posts_counter
  before_destroy :decrement_posts_counter

  def increment_posts_counter
    author.increment!(:posts_counter)
  end

  def decrement_posts_counter
    author.decrement!(:posts_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5).to_a
  end
end
