# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151010081113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fraud_categories", force: :cascade do |t|
    t.string   "code"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "incidents", force: :cascade do |t|
    t.integer  "fraud_category_id"
    t.string   "state"
    t.string   "region"
    t.string   "township"
    t.text     "description"
    t.datetime "reported_time"
    t.string   "photo"
    t.string   "reporter_name"
    t.string   "reporter_contact"
    t.string   "device_id"
    t.integer  "view_count",        default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "incidents", ["device_id"], name: "index_incidents_on_device_id", using: :btree
  add_index "incidents", ["fraud_category_id"], name: "index_incidents_on_fraud_category_id", using: :btree

end
