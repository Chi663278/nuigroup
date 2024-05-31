class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def index
    @posts = Post.where(user_id: @user.id).includes(:user).order("created_at DESC")
    @screen_name = User.find(params[:post_id]).screen_name

  end

  def show

  end

  def edit
  end

  def update
    if @user.update(user_params)
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

  def set_current_user
    @user = current_user
  end
end
