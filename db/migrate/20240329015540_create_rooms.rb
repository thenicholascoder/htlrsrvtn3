class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :desc
      t.string :section_name
      t.string :section_title
      t.string :section_desc
      t.integer :suite_size
      t.integer :max_guests
      t.integer :bedroom_count
      t.decimal :price
      t.integer :featured_amenity_id
      t.references :location, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
