require "test_helper"

class Public::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_users_index_url
    assert_response :success
  end

  test "should get show" do
    get public_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_users_edit_url
    assert_response :success
  end

  test "should get followings" do
    get public_users_followings_url
    assert_response :success
  end

  test "should get followers" do
    get public_users_followers_url
    assert_response :success
  end

  test "should get favorites" do
    get public_users_favorites_url
    assert_response :success
  end

  test "should get check" do
    get public_users_check_url
    assert_response :success
  end
end
