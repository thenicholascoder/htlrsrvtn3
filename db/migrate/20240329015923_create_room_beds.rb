class CreateRoomBeds < ActiveRecord::Migration[7.1]
  def change
    create_table :room_beds do |t|
      t.integer :count
      t.references :bed, foreign_key: { on_delete: :cascade }
      t.references :room, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
