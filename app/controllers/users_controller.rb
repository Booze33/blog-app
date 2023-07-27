class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    if params[:id] == "sign_out"
      sign_out_current_user
      redirect_to new_user_session_path, notice: "You have signed out successfully!"
    else
      @user = User.find(params[:id])
    end
  end

  private

  def sign_out_current_user
    sign_out(current_user)
    reset_session
  end
end
