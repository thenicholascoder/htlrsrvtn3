require "test_helper"

class HotelListingsManager::RoomBedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hotel_listings_manager_room_beds_index_url
    assert_response :success
  end
end
