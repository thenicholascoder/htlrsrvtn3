class CreateBeds < ActiveRecord::Migration[7.1]
  def change
    create_table :beds do |t|
      t.string :name
      t.decimal :length, precision: 10, scale: 2
      t.decimal :width, precision: 10, scale: 2
      t.timestamps
    end
  end
end
