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

ActiveRecord::Schema.define(version: 2019_01_09_082153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "group_user_relations", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_user_relations_on_group_id"
    t.index ["user_id"], name: "index_group_user_relations_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "title", null: false
    t.text "info", default: "", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_label_relations", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_task_label_relations_on_label_id"
    t.index ["task_id"], name: "index_task_label_relations_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deadline", default: -> { "now()" }, null: false
    t.string "status", default: "未着手", null: false
    t.integer "priority", default: 2, null: false
    t.bigint "user_id"
    t.bigint "group_id"
    t.index ["group_id"], name: "index_tasks_on_group_id"
    t.index ["priority"], name: "index_tasks_on_priority"
    t.index ["title"], name: "index_tasks_on_title"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "groups", "users"
  add_foreign_key "tasks", "groups"
  add_foreign_key "tasks", "users"
end
