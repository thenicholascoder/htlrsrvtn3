require "test_helper"

class HotelListingsManager::LocationPhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get hotel_listings_manager_location_photos_show_url
    assert_response :success
  end

  test "should get index" do
    get hotel_listings_manager_location_photos_index_url
    assert_response :success
  end

  test "should get new" do
    get hotel_listings_manager_location_photos_new_url
    assert_response :success
  end

  test "should get edit" do
    get hotel_listings_manager_location_photos_edit_url
    assert_response :success
  end
end
