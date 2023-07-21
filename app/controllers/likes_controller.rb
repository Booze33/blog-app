class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(author: current_user, post: @post)

    if @like.save
      @post.increment!(:likes_counter)
      flash[:success] = 'Post liked!'
    else
      flash[:error] = 'Like creation failed'
    end

    redirect_to user_post_path(@post.author, @post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = Like.find_by(author: current_user, post: @post)

    if @like.destroy
      @post.decrement!(:likes_counter)
      flash[:success] = 'Post unliked!'
    else
      flash[:error] = 'Unlike failed'
    end

    redirect_to user_post_path(@post.author, @post)
  end
end
