class BookingsController < ApplicationController
  SessionsHelper
  def index
    @reservations = Reservation.where(user_id: session[:user_id]).paginate(page: params[:page]).per_page(10)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to bookings_path
    flash[:success] = "Reservation was successfully cancelled."
  end
end
