require "test_helper"

class Admin::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get user_comments" do
    get admin_comments_user_comments_url
    assert_response :success
  end

  test "should get post_comments" do
    get admin_comments_post_comments_url
    assert_response :success
  end

  test "should get update" do
    get admin_comments_update_url
    assert_response :success
  end
end
