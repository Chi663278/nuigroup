class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by(screen_name: params[:screen_name])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find_by(screen_name: params[:screen_name])
    current_user.unfollow(user)
    redirect_to request.referer
  end
end
