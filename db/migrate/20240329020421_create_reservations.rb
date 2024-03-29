class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.string :guest_prefix
      t.string :guest_firstname
      t.string :guest_lastname
      t.string :guest_phone
      t.string :guest_email
      t.string :guest_country
      t.string :guest_address
      t.string :guest_city
      t.string :guest_zip_code
      t.string :guest_check_in_reason
      t.string :guest_special_needs
      t.date :check_in_date
      t.date :check_out_date
      t.integer :adults_count
      t.integer :children_count
      t.decimal :total_bill, precision: 10, scale: 2
      t.time :reservation_timestamp
      t.boolean :checkin_confirmed
      t.boolean :checkout_confirmed
      t.boolean :room_key_returned
      t.string :review
      t.time :review_timestamp
      t.references :user, foreign_key: { on_delete: :cascade }
      t.references :room, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
