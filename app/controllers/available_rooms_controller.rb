class AvailableRoomsController < ApplicationController
  def new
  end

  def index
    store_last_page
    all_room_numbers_room_ids = RoomNumber.where(is_under_maintenance: false).where(is_smoke_free: params[:is_smoke_free]).pluck(:room_id)
    all_current_reserved_room_ids = Reservation.where('check_in_date < ? AND check_out_date > ?', params[:check_out_date], params[:check_in_date]).pluck(:room_id)
    all_room_numbers_minus_all_current_reserved_room_ids = all_room_numbers_room_ids.difference(all_current_reserved_room_ids)
    all_room_numbers_minus_all_current_reserved_room_ids_unique = all_room_numbers_minus_all_current_reserved_room_ids.uniq
    @available_rooms = Room.where(location_id: params[:location_id]).where(id: all_room_numbers_minus_all_current_reserved_room_ids_unique).where("max_guests <= ?", params[:children_count]+params[:adults_count])
    @check_in_date = params[:check_in_date]
    @check_out_date = params[:check_out_date]
    @children_count = params[:children_count]
    @adults_count = params[:adults_count]
  end

  def update
  end

  def destroy
  end

  def create
  end

  def edit
  end
end
