class HotelListingsManager::BookingsController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions

  def index
    store_last_page
    @reservations = Reservation.paginate(page: params[:page]).per_page(10)

  end

  def new
    @reservation = Reservation.new
  end

  def create

    @reservation = Reservation.new(reservation_params)
    @reservation.reservation_timestamp = Time.current

    current_reserved_and_desired_rooms_count = Reservation.where('check_in_date < ? AND check_out_date > ?', params[:reservation][:check_out_date], params[:reservation][:check_in_date]).where(room_id: params[:reservation][:room_id]).count
    current_desired_rooms_count = RoomNumber.where(room_id: params[:reservation][:room_id]).count

    puts "RD > #{current_reserved_and_desired_rooms_count}, D> #{current_desired_rooms_count}"
      if current_desired_rooms_count > current_reserved_and_desired_rooms_count
        puts "THIS WORKS 34"
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
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(params.require(:reservation).permit(:guest_prefix, :guest_firstname, :guest_lastname, :guest_phone, :guest_email, :guest_country, :guest_address, :guest_city, :guest_zip_code, :guest_check_in_reason, :guest_special_needs, :check_in_date, :check_out_date, :adults_count, :children_count, :total_bill, :checkin_confirmed, :checkout_confirmed, :room_key_returned, :review, :review_timestamp, :user_id, :room_id))
      redirect_to retrieve_last_page_or_default
      flash[:success] = "Booking was successfully updated."
    else
      @errors = @reservation.errors.full_messages
      puts @errors
      flash[:danger] = @errors.join(', ')
      render :new
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to retrieve_last_page_or_default
    flash[:success] = "Reservation was successfully cancelled."
  end

  private

  def overlapping_reservations?(check_in_date, check_out_date)
    Reservation.where('check_in_date < ? AND check_out_date > ?', check_out_date, check_in_date).exists?
  end

  def reservation_params
    params.require(:reservation).permit(:guest_prefix, :guest_firstname, :guest_lastname, :guest_phone, :guest_email, :guest_country, :guest_address, :guest_city, :guest_zip_code, :guest_check_in_reason, :guest_special_needs, :check_in_date, :check_out_date, :adults_count, :children_count, :total_bill, :user_id, :room_id)
  end

end
