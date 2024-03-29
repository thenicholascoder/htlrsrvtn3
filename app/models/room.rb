class Room < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservation
  has_many :room_numbers
  has_many :room_bed, dependent: :destroy
  has_many :bed, through: :room_bed
  belongs_to :location
  belongs_to :category
  has_many :room_photo, dependent: :destroy
  has_many :photo, through: :room_photo
  has_many :room_amenities, dependent: :destroy
  has_many :amenities, through: :room_amenities
end
