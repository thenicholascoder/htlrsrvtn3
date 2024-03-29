class RoomPhoto < ApplicationRecord
  belongs_to :photo
  belongs_to :room
end
