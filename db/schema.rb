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

ActiveRecord::Schema[7.2].define(version: 2025_10_22_073448) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.bigint "travel_record_id", null: false
    t.string "name", null: false
    t.integer "quantity", default: 1
    t.text "memo"
    t.boolean "is_checked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_items_on_name"
    t.index ["travel_record_id", "created_at"], name: "index_items_on_travel_record_id_and_created_at"
    t.index ["travel_record_id"], name: "index_items_on_travel_record_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location", "name"], name: "index_places_on_location_and_name"
    t.index ["location"], name: "index_places_on_location"
    t.index ["name"], name: "index_places_on_name"
  end

  create_table "shared_comments", force: :cascade do |t|
    t.bigint "travel_record_id", null: false
    t.string "commenter_name", null: false
    t.string "commenter", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["travel_record_id"], name: "index_shared_comments_on_travel_record_id"
  end

  create_table "shared_links", force: :cascade do |t|
    t.bigint "travel_record_id", null: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_shared_links_on_token", unique: true
    t.index ["travel_record_id"], name: "index_shared_links_on_travel_record_id"
  end

  create_table "travel_images", force: :cascade do |t|
    t.bigint "travel_record_id", null: false
    t.string "image_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["travel_record_id", "created_at"], name: "index_travel_images_on_travel_record_id_and_created_at"
    t.index ["travel_record_id"], name: "index_travel_images_on_travel_record_id"
  end

  create_table "travel_places", force: :cascade do |t|
    t.bigint "place_id", null: false
    t.bigint "travel_record_id", null: false
    t.date "visited_at"
    t.integer "cost"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id", "visited_at"], name: "index_travel_places_on_place_id_and_visited_at"
    t.index ["place_id"], name: "index_travel_places_on_place_id"
    t.index ["travel_record_id", "visited_at"], name: "index_travel_places_on_travel_record_id_and_visited_at"
    t.index ["travel_record_id"], name: "index_travel_places_on_travel_record_id"
    t.index ["visited_at"], name: "index_travel_places_on_visited_at"
  end

  create_table "travel_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "memo"
    t.integer "amount_used", default: 0
    t.string "title", null: false
    t.date "travel_date", null: false
    t.boolean "want_to_visit_again", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["travel_date"], name: "index_travel_records_on_travel_date"
    t.index ["user_id", "travel_date"], name: "index_travel_records_on_user_id_and_travel_date"
    t.index ["user_id", "want_to_visit_again"], name: "index_travel_records_on_user_id_and_want_to_visit_again"
    t.index ["user_id"], name: "index_travel_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "travel_records"
  add_foreign_key "shared_comments", "travel_records"
  add_foreign_key "shared_links", "travel_records"
  add_foreign_key "travel_images", "travel_records"
  add_foreign_key "travel_places", "places"
  add_foreign_key "travel_places", "travel_records"
  add_foreign_key "travel_records", "users"
end
