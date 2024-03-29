class Location < ApplicationRecord
  has_many :rooms
  has_one :location_photo, dependent: :destroy
  has_one :photo, through: :location_photo
end
