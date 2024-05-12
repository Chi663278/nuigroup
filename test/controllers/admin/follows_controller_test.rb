require "test_helper"

class Admin::FollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get following" do
    get admin_follows_following_url
    assert_response :success
  end

  test "should get follower" do
    get admin_follows_follower_url
    assert_response :success
  end
end
