class RoomDetailsController < ApplicationController
  def index
    @room = Room.find_by(id: params[:room_id])
    puts @room
  end
end
