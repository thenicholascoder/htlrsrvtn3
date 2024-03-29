class HotelListingsManagerController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions

  def index
    store_last_page
  end
end
