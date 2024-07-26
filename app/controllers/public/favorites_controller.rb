class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index #ポスト別 Favorites
    favorites = Favorite.where(post_id: params[:post_id]).pluck(:user_id)
    @users = User.only_active.where(id: favorites)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def user_favs #ユーザ別 Favorites
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @posts = Post.only_active.where(id: favorites).order(created_at: :desc)
  end

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save!
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy!
    redirect_to request.referer
  end
end
