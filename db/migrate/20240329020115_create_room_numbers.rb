class CreateRoomNumbers < ActiveRecord::Migration[7.1]
  def change
    create_table :room_numbers do |t|
      t.integer :room_num
      t.integer :floor_num
      t.boolean :is_smoke_free, default: true
      t.boolean :is_under_maintenance, default: false
      t.references :room, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
    add_index :room_numbers, [:room_num, :floor_num], unique: true
  end
end
