class RoomNumber < ApplicationRecord
  validates :room_num, uniqueness: { scope: :floor_num }
  belongs_to :room
  # has_many :reservations, dependent: :destroy
  # has_many :users, through: :reservations
end
