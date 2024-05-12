require "test_helper"

class Admin::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get user_favs" do
    get admin_favorites_user_favs_url
    assert_response :success
  end

  test "should get post_favs" do
    get admin_favorites_post_favs_url
    assert_response :success
  end

  test "should get update" do
    get admin_favorites_update_url
    assert_response :success
  end
end
