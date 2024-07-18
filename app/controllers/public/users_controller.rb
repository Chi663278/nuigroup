class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :bye]

  def index
    user_ids = current_user.followings.only_active + [current_user.id]
    @posts = Post.only_active.where(user_id: user_ids).order(created_at: :desc).page(params[:page])
    @comments = Comment.only_active.where(post_id: @posts.pluck(:id)).order(created_at: :asc)
    respond_to do |format|
     format.html
     format.json { render 'calendar' }
    end
  end

  def events
    @user = User.only_active.find_by(screen_name: params[:screen_name])
    @posts = Post.only_active.where(user_id: @user.id).order(created_at: :desc)
    respond_to do |format|
     format.html
     format.json { render 'calendar' }
    end
  end

  def show
    @user = User.only_active.find_by(screen_name: params[:screen_name])
    if @user
      @posts = Post.only_active.where(user_id: @user.id).order(created_at: :desc).page(params[:page])
      @comments = Comment.only_active.where(post_id: @posts.pluck(:id)).order(created_at: :asc)
    else
      redirect_to timeline_path, notice: 'ユーザーが存在しません。'
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      respond_to do |format|
        format.html { redirect_to edit_user_path, notice: 'プロフィールを更新しました。' }
        format.js { flash.now[:notice] = 'プロフィールを更新しました。' }
      end
    else
      respond_to do |format|
        flash.now[:notice] = 'プロフィールの更新に失敗しました。'
        format.html { render :edit }
        format.js
      end
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
