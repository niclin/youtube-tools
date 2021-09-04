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

ActiveRecord::Schema.define(version: 2021_09_04_090322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "donate_events", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.integer "goal_amount", null: false
    t.integer "total_amount", default: 0, null: false
    t.integer "starting_amount", default: 0, null: false
    t.date "end_after", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
  end

  create_table "donate_histories", force: :cascade do |t|
    t.integer "user_id"
    t.string "currency", null: false
    t.integer "amount_micros", null: false
    t.string "display_name"
    t.string "donate_channel_id"
    t.string "self_channel_id"
    t.integer "message_type"
    t.string "uid"
    t.string "kind"
    t.string "comment"
    t.datetime "donate_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "identities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "refresh_token"
    t.integer "expires_at_unix"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "identities", "users"
end
