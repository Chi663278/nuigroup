class Admin::FollowsController < ApplicationController
  before_action :authenticate_admin!
  def following
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  def follower
    @user = User.find(params[:id])
    @followers = @user.followers
  end
end
