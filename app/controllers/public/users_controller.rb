class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def timeline
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids])
  end

  def index
    @posts = Post.where(params[:screen_name])
  end

  def edit
    @user = User.find(params[:screen_name])
  end

  def update
    @user = User.find(params[:screen_name])
    @user.update(user_params)
    redirect_to timeline_path(@user.screen_name)
  end

  private

  def user_params
    params.require(:user).permit(:name, :image)
  end

  def is_matching_login_user
    user = User.find(params[:screen_name])
    unless user.screen_name == current_user.screen_name
      redirect_to user_timeline_path
    end
  end
end
