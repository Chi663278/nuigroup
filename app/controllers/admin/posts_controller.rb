class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def user_posts
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  def show
  end

  def update
    post = Post.find(params[:id])
    if post.is_active
      post.update!(is_active: false)
    else
      post.update!(is_active: true)
    end
    if post.is_active
      redirect_to admin_user_posts_path(post.user_id), notice: 'ポストを有効にしました。'
    else
      redirect_to admin_user_posts_path(post.user_id), notice: 'ポストを削除しました。'
    end
  end
end
