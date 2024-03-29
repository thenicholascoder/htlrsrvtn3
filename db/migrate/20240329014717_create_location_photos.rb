class CreateLocationPhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :location_photos do |t|
      t.references :photo, foreign_key: { on_delete: :cascade }
      t.references :location, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
