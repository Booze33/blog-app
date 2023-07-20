class PostsController < ApplicationController
  before_action :set_user, only: [:index, :new, :create]
  before_action :set_post, only: [:show]

  def index
    @posts = @user.posts
  end

  def show
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'New post successfully added!'
      redirect_to user_posts_path
    else
      flash.now[:error] = 'Post creation failed'
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
