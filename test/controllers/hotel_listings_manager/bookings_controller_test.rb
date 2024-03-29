require "test_helper"

class HotelListingsManager::BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get hotel_listings_manager_bookings_new_url
    assert_response :success
  end

  test "should get index" do
    get hotel_listings_manager_bookings_index_url
    assert_response :success
  end

  test "should get create" do
    get hotel_listings_manager_bookings_create_url
    assert_response :success
  end

  test "should get edit" do
    get hotel_listings_manager_bookings_edit_url
    assert_response :success
  end

  test "should get update" do
    get hotel_listings_manager_bookings_update_url
    assert_response :success
  end

  test "should get destroy" do
    get hotel_listings_manager_bookings_destroy_url
    assert_response :success
  end
end
