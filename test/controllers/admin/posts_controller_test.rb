require "test_helper"

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get user_posts" do
    get admin_posts_user_posts_url
    assert_response :success
  end

  test "should get show" do
    get admin_posts_show_url
    assert_response :success
  end

  test "should get update" do
    get admin_posts_update_url
    assert_response :success
  end
end
