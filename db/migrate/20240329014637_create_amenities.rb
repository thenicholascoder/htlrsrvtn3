class CreateAmenities < ActiveRecord::Migration[7.1]
  def change
    create_table :amenities do |t|
      t.string :name
      t.references :photo, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
