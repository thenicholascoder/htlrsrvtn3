require "test_helper"

class HotelListingsManager::RoomPhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hotel_listings_manager_room_photos_index_url
    assert_response :success
  end
end
