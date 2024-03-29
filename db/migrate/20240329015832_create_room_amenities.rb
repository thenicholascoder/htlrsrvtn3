class CreateRoomAmenities < ActiveRecord::Migration[7.1]
  def change
    create_table :room_amenities do |t|
      t.references :amenity, foreign_key: { on_delete: :cascade }
      t.references :room, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
