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

ActiveRecord::Schema.define(version: 2021_03_03_120341) do

  create_table "movements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "rover_id"
    t.integer "x", null: false
    t.integer "y", null: false
    t.string "orientation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rover_id"], name: "index_movements_on_rover_id"
  end

  create_table "plateaus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "size", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rovers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "plateau_id"
    t.string "position", null: false
    t.string "comand", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plateau_id"], name: "index_rovers_on_plateau_id"
  end

  add_foreign_key "movements", "rovers"
  add_foreign_key "rovers", "plateaus"
end
