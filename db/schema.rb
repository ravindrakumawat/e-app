# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_23_171205) do

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.text "about"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "post_code"
    t.string "country"
    t.string "contact_email"
    t.string "phone_number"
    t.string "owner_name"
    t.date "founded_date"
    t.integer "no_of_employees"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "owner_id"
    t.string "domain"
    t.string "logo"
    t.string "company_name"
    t.string "external_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "business_id"
    t.string "email"
    t.string "designation"
    t.date "joining_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
  end

end
