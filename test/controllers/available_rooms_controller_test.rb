require "test_helper"

class AvailableRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get available_rooms_new_url
    assert_response :success
  end

  test "should get index" do
    get available_rooms_index_url
    assert_response :success
  end

  test "should get update" do
    get available_rooms_update_url
    assert_response :success
  end

  test "should get destroy" do
    get available_rooms_destroy_url
    assert_response :success
  end

  test "should get create" do
    get available_rooms_create_url
    assert_response :success
  end

  test "should get edit" do
    get available_rooms_edit_url
    assert_response :success
  end
end
