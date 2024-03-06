require "test_helper"

class ChatControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chat_index_url
    assert_response :success
  end

  test "should get show" do
    get chat_show_url
    assert_response :success
  end

  test "should get new" do
    get chat_new_url
    assert_response :success
  end

  test "should get create" do
    get chat_create_url
    assert_response :success
  end

  test "should get edit" do
    get chat_edit_url
    assert_response :success
  end

  test "should get update" do
    get chat_update_url
    assert_response :success
  end

  test "should get destroy" do
    get chat_destroy_url
    assert_response :success
  end
end
