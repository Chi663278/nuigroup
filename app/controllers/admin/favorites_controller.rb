class Admin::FavoritesController < ApplicationController
  before_action :authenticate_admin!
  def user_favs
    @user = User.find(params[:id])
    @favorites = Favorite.where(user_id: @user.id)
  end

  def post_favs
    @post = Post.find(params[:id])
    @favorites = Favorite.where(post_id: @post.id)
  end
end
