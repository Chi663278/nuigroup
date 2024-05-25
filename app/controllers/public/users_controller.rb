class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def timeline
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids])
  end

  def index
    @posts = Post.where(params[:id])
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to timeline_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :image)
  end

  def set_current_user
    @user = current_user
  end
end
