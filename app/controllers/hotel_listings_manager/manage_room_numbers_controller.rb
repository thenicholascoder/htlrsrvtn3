class HotelListingsManager::ManageRoomNumbersController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions
  attr_accessor :amenity_ids

  def index
    store_last_page
    # @room_numbers = RoomNumber.all
    @room_numbers = RoomNumber.where(room_id: params[:room_id]).paginate(page: params[:page]).per_page(10)
  end

  def new
    @room_number = RoomNumber.new
  end

  def create
    @room_number = RoomNumber.new(params.require(:room_number).permit(:room_num, :floor_num, :is_smoke_free, :is_under_maintenance))
    @room_number.room_id = params[:room_id]
    puts @room_number
    if @room_number.save
      redirect_to retrieve_last_page_or_default
      flash[:success] = "Room Number was successfully created."
    else
      @errors = @room_number.errors.full_messages
      redirect_to retrieve_last_page_or_default
      flash[:danger] = @errors.join(', ')
    end
  end

  def edit
    @room_number = RoomNumber.find(params[:id])
  end

  def update
    @room_number = RoomNumber.find(params[:id])
    if @room_number.update(params.require(:room_number).permit(:room_num, :floor_num, :is_smoke_free, :is_under_maintenance, :room_id))
      redirect_to retrieve_last_page_or_default
      flash[:success] = "Room Number was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @room_number = RoomNumber.find(params[:id])
    @room_number.destroy
    redirect_to retrieve_last_page_or_default
    flash[:success] = "Room Number was successfully destroyed."
  end
end
