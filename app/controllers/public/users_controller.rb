class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    user_ids = current_user.followings.includes(:id) + [current_user.id]
    @posts = Post.only_active.where(user_id: user_ids).order(created_at: :desc)
    @comments = Comment.only_active.where(post_id: @posts.pluck(:id)).order(created_at: :asc)
  end

  def show
    @user = User.only_active.find_by(screen_name: params[:screen_name])
    if @user
      @posts = Post.only_active.where(user_id: @user.id).order(created_at: :desc)
      @comments = Comment.only_active.where(post_id: @posts.pluck(:id)).order(created_at: :asc)
    else
      redirect_to timeline_path, notice: 'ユーザーが存在しません。'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_edit_path(current_user.id), notice: 'プロフィールを更新しました。'
    else
      flash.now[:notice] = 'プロフィールの更新に失敗しました。'
      render :edit
    end
  end

  def followings
    @following_user = User.only_active.find_by(screen_name: params[:screen_name])
    @following_users = @following_user.followings
  end

  def followers
    @followed_user = User.only_active.find(params[:screen_name])
    @followed_users = @followed_user.followers
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :email, :bio)
  end
end
