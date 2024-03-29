require "test_helper"

class HotelListingsManager::ManageRoomNumbersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get hotel_listings_manager_manage_room_numbers_new_url
    assert_response :success
  end

  test "should get index" do
    get hotel_listings_manager_manage_room_numbers_index_url
    assert_response :success
  end

  test "should get create" do
    get hotel_listings_manager_manage_room_numbers_create_url
    assert_response :success
  end

  test "should get edit" do
    get hotel_listings_manager_manage_room_numbers_edit_url
    assert_response :success
  end

  test "should get update" do
    get hotel_listings_manager_manage_room_numbers_update_url
    assert_response :success
  end

  test "should get destroy" do
    get hotel_listings_manager_manage_room_numbers_destroy_url
    assert_response :success
  end
end
