class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[index new create]
  before_action :set_post, only: [:show]

  def index
    @posts = Post.includes(:comments).all
  end

  def show
    @post = Post.find_by(id: params[:id])

    if @post.nil?
      flash[:error] = 'Post not found'
      redirect_to root_path
    else
      @user = @post.author
    end
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = Post.new(post_params)
    @post.author = @user

    if @post.save
      flash[:success] = 'New post successfully added!'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:error] = 'Post creation failed'
      render :new
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post successfully deleted'
    redirect_to user_posts_path(user_id: current_user.id)
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
