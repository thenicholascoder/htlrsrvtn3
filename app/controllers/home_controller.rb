class HomeController < ApplicationController
  def show
    store_last_page
    @locations = Location.all
  end
end
