class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user_and_post, only: %i[destroy]
  before_action :set_user_and_post_for_new, only: %i[new create]

  def index_api
    @comments = Comment.where(post_id: params[:post_id])
    respond_to do |format|
      format.json { render json:@comments }
    end
  end

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

  def destroy
    @comment.destroy
    flash[:success] = 'Comment successfully deleted'
    redirect_to user_post_path(@user, @post)
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def set_user_and_post_for_new
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :author_id).merge(author_id: current_user.id)
  end
end
