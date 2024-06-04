class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    following = current_user.relationships.build(follower_id: params[:screen_name])
    following.save
    redirect_to request.referer
  end

  def destroy
    following = current_user.relationships.find_by(follower_id: params[:screen_name])
    following.destroy
    redirect_to request.referer
  end
end
