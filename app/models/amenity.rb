class Amenity < ApplicationRecord
  belongs_to :photo
  has_many :room_amenity
end
