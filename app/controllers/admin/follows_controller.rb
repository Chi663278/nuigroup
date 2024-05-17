class Admin::FollowsController < ApplicationController
  before_action :authenticate_admin!
  def following
  end

  def follower
  end
end
