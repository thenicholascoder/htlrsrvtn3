class CreateRoomCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :room_categories do |t|
      t.references :room, foreign_key: { on_delete: :cascade }
      t.references :category, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
