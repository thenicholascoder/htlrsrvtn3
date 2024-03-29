class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end
  def room
    puts params[:room_id]
  end
end
