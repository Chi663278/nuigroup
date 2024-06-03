class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    user_ids = current_user.followings.includes(:id) + [current_user.id]
    @posts = Post.only_active.where(user_id: user_ids).order(created_at: :desc)
    @comments = Comment.only_active.where(post_id: @posts.pluck(:id)).order(created_at: :asc)
  end

  def show

  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_edit_path(@user.id), notice: 'プロフィールを更新しました。'
    else
      flash.now[:notice] = 'プロフィールの更新に失敗しました。'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :email, :bio)
  end
end
