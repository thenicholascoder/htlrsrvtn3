class Photo < ApplicationRecord
  has_many :room_photo
  has_many :room, through: :room_photo
  has_many :amenity
  has_one :location_photo, dependent: :destroy
  has_one :location, through: :location_photo
  has_many :room_bed
end
