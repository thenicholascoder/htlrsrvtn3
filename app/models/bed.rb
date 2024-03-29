class Bed < ApplicationRecord
  has_many :room_bed
  has_one :room, through: :room_bed
end
