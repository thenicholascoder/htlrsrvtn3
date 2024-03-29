class CreateRoomPhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :room_photos do |t|
      t.references :room, foreign_key: { on_delete: :cascade }
      t.references :photo, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
