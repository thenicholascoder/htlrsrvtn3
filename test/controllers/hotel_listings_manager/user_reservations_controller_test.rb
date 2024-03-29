require "test_helper"

class HotelListingsManager::UserReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hotel_listings_manager_user_reservations_index_url
    assert_response :success
  end
end
