class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :city
      t.string :country
      t.string :address
      t.timestamps
    end
  end
end
