require "test_helper"

class HotelListingsManager::RoomAmenitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get hotel_listings_manager_room_amenities_new_url
    assert_response :success
  end

  test "should get index" do
    get hotel_listings_manager_room_amenities_index_url
    assert_response :success
  end

  test "should get create" do
    get hotel_listings_manager_room_amenities_create_url
    assert_response :success
  end

  test "should get edit" do
    get hotel_listings_manager_room_amenities_edit_url
    assert_response :success
  end

  test "should get update" do
    get hotel_listings_manager_room_amenities_update_url
    assert_response :success
  end

  test "should get destroy" do
    get hotel_listings_manager_room_amenities_destroy_url
    assert_response :success
  end
end
