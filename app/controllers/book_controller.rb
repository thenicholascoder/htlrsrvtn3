class BookController < ApplicationController
include SessionsHelper
  def new
    @reservation = Reservation.new()
    @user_id = current_user.id
    @room_id = params[:room_id]
    @total_bill = params[:total_bill]
    @check_in_date = params[:check_in_date]
    @check_out_date = params[:check_out_date]
    @children_count = params[:children_count]
    @adults_count = params[:adults_count]
  end

  def index
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.reservation_timestamp = Time.current

    current_reserved_and_desired_rooms_count = Reservation.where('check_in_date < ? AND check_out_date > ?', params[:reservation][:check_out_date], params[:reservation][:check_in_date]).where(room_id: params[:reservation][:room_id]).count
    current_desired_rooms_count = RoomNumber.where(room_id: params[:reservation][:room_id]).count

    if current_desired_rooms_count > current_reserved_and_desired_rooms_count
      if @reservation.save
          redirect_to retrieve_last_page_or_default
          flash[:success] = "Reservation was successfully created."
      else
        @errors = @reservation.errors.full_messages
        flash[:danger] = @errors.join(', ')
        render :new
      end
    else
      flash[:danger] = "No rooms available."
      redirect_to retrieve_last_page_or_default
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  private

    def overlapping_reservations?(check_in_date, check_out_date)
      Reservation.where('check_in_date < ? AND check_out_date > ?', check_out_date, check_in_date).exists?
    end

    def reservation_params
      params.require(:reservation).permit(:guest_prefix, :guest_firstname, :guest_lastname, :guest_phone, :guest_email, :guest_country, :guest_address, :guest_city, :guest_zip_code, :guest_check_in_reason, :guest_special_needs, :check_in_date, :check_out_date, :adults_count, :children_count, :total_bill, :user_id, :room_id)
    end
end
