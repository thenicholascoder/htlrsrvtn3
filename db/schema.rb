# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_29_020421) do
  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.integer "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_amenities_on_photo_id"
  end

  create_table "beds", force: :cascade do |t|
    t.string "name"
    t.decimal "length", precision: 10, scale: 2
    t.decimal "width", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_photos", force: :cascade do |t|
    t.integer "photo_id"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_location_photos_on_location_id"
    t.index ["photo_id"], name: "index_location_photos_on_photo_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "country"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.string "guest_prefix"
    t.string "guest_firstname"
    t.string "guest_lastname"
    t.string "guest_phone"
    t.string "guest_email"
    t.string "guest_country"
    t.string "guest_address"
    t.string "guest_city"
    t.string "guest_zip_code"
    t.string "guest_check_in_reason"
    t.string "guest_special_needs"
    t.date "check_in_date"
    t.date "check_out_date"
    t.integer "adults_count"
    t.integer "children_count"
    t.decimal "total_bill", precision: 10, scale: 2
    t.time "reservation_timestamp"
    t.boolean "checkin_confirmed"
    t.boolean "checkout_confirmed"
    t.boolean "room_key_returned"
    t.string "review"
    t.time "review_timestamp"
    t.integer "user_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_reservations_on_room_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "room_amenities", force: :cascade do |t|
    t.integer "amenity_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_room_amenities_on_amenity_id"
    t.index ["room_id"], name: "index_room_amenities_on_room_id"
  end

  create_table "room_beds", force: :cascade do |t|
    t.integer "count"
    t.integer "bed_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bed_id"], name: "index_room_beds_on_bed_id"
    t.index ["room_id"], name: "index_room_beds_on_room_id"
  end

  create_table "room_categories", force: :cascade do |t|
    t.integer "room_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_room_categories_on_category_id"
    t.index ["room_id"], name: "index_room_categories_on_room_id"
  end

  create_table "room_numbers", force: :cascade do |t|
    t.integer "room_num"
    t.integer "floor_num"
    t.boolean "is_smoke_free", default: true
    t.boolean "is_under_maintenance", default: false
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_numbers_on_room_id"
    t.index ["room_num", "floor_num"], name: "index_room_numbers_on_room_num_and_floor_num", unique: true
  end

  create_table "room_photos", force: :cascade do |t|
    t.integer "room_id"
    t.integer "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_room_photos_on_photo_id"
    t.index ["room_id"], name: "index_room_photos_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.string "section_name"
    t.string "section_title"
    t.string "section_desc"
    t.integer "suite_size"
    t.integer "max_guests"
    t.integer "bedroom_count"
    t.decimal "price"
    t.integer "featured_amenity_id"
    t.integer "location_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_rooms_on_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "country"
    t.string "email"
    t.string "mobile"
    t.boolean "is_admin", default: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "amenities", "photos", on_delete: :cascade
  add_foreign_key "location_photos", "locations", on_delete: :cascade
  add_foreign_key "location_photos", "photos", on_delete: :cascade
  add_foreign_key "reservations", "rooms", on_delete: :cascade
  add_foreign_key "reservations", "users", on_delete: :cascade
  add_foreign_key "room_amenities", "amenities", on_delete: :cascade
  add_foreign_key "room_amenities", "rooms", on_delete: :cascade
  add_foreign_key "room_beds", "beds", on_delete: :cascade
  add_foreign_key "room_beds", "rooms", on_delete: :cascade
  add_foreign_key "room_categories", "categories", on_delete: :cascade
  add_foreign_key "room_categories", "rooms", on_delete: :cascade
  add_foreign_key "room_numbers", "rooms", on_delete: :cascade
  add_foreign_key "room_photos", "photos", on_delete: :cascade
  add_foreign_key "room_photos", "rooms", on_delete: :cascade
  add_foreign_key "rooms", "locations"
end
