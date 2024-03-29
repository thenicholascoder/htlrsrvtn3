class AvailableRoomsController < ApplicationController
  def new
  end

  def index
    all_room_numbers_room_ids = RoomNumber.pluck(:room_id)
    puts "all_room_numbers_room_ids = #{all_room_numbers_room_ids}"
    all_current_reserved_room_ids = Reservation.where('check_in_date < ? AND check_out_date > ?', params[:check_out_date], params[:check_in_date]).pluck(:room_id)
    puts "all_current_reserved_room_ids = #{all_current_reserved_room_ids}"
    all_room_numbers_minus_all_current_reserved_room_ids = all_room_numbers_room_ids.difference(all_current_reserved_room_ids)
    puts "all_room_numbers_minus_all_current_reserved_room_ids = #{all_room_numbers_minus_all_current_reserved_room_ids}"
    all_room_numbers_minus_all_current_reserved_room_ids_unique = all_room_numbers_minus_all_current_reserved_room_ids.uniq
    puts "all_room_numbers_minus_all_current_reserved_room_ids_unique = #{all_room_numbers_minus_all_current_reserved_room_ids_unique}"
    # # if current_desired_rooms_count > current_reserved_and_desired_rooms_count
    @available_rooms = Room.where(location_id: params[:location_id]).where(max_guests: params[:children_count]..params[:adults_count]).where(id: all_room_numbers_minus_all_current_reserved_room_ids_unique)
    puts "available_rooms = #{@available_rooms}"
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
