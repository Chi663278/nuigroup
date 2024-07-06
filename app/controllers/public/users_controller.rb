class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :bye]

  def index
    user_ids = current_user.followings.only_active + [current_user.id]
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
      redirect_to edit_user_path(current_user.id), notice: 'プロフィールを更新しました。'
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
    @follower_user = User.only_active.find_by(screen_name: params[:screen_name])
    @follower_users = @follower_user.followers
  end

  def withdraw
  end

  def destroy
    current_user.update!(is_active: false)
    reset_session
    redirect_to bye_path, notice: 'nuigroupを退会しました。'
  end

  def bye
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :email, :bio)
  end
end
