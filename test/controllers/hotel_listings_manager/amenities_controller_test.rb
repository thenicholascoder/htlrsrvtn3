require "test_helper"

class HotelListingsManager::AmenitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hotel_listings_manager_amenities_index_url
    assert_response :success
  end
end
