# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161231153753) do

  create_table "invite_codes", force: :cascade do |t|
    t.string  "code"
    t.integer "used_by"
  end

  create_table "logs", force: :cascade do |t|
    t.string   "created_by"
    t.string   "created_by_uid"
    t.datetime "created_at"
    t.string   "description"
    t.string   "content"
    t.boolean  "resolved",       default: false
  end

  create_table "samples", force: :cascade do |t|
    t.integer  "samples_group_id"
    t.string   "created_by"
    t.string   "created_by_uid"
    t.datetime "created_time"
    t.string   "content"
    t.boolean  "resolved",         default: false
    t.index ["samples_group_id"], name: "index_samples_on_samples_group_id"
  end

  create_table "samples_group", force: :cascade do |t|
    t.datetime "created_at"
    t.string   "title"
    t.string   "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
