class CommentsController < ApplicationController
  before_action :set_user_and_post, only: [:new, :create]

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'Comment Added Successfully'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:error] = 'Failed To Create Comment'
      render :new
    end
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :author_id).merge(author_id: current_user.id)
  end
end
