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

ActiveRecord::Schema.define(version: 2021_12_28_043602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "deleted_at"
    t.bigint "session_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_categories_on_session_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.string "file"
    t.datetime "deleted_at"
    t.bigint "session_id", null: false
    t.bigint "category_id", null: false
    t.bigint "unit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_lessons_on_category_id"
    t.index ["session_id"], name: "index_lessons_on_session_id"
    t.index ["unit_id"], name: "index_lessons_on_unit_id"
  end

  create_table "presentations", force: :cascade do |t|
    t.string "link"
    t.string "file"
    t.datetime "deleted_at"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_presentations_on_lesson_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "title"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "created_by"
  end

  create_table "programs_users", force: :cascade do |t|
    t.bigint "program_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_programs_users_on_program_id"
    t.index ["user_id"], name: "index_programs_users_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "link"
    t.string "file"
    t.datetime "deleted_at"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_resources_on_lesson_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "title"
    t.datetime "deleted_at"
    t.bigint "program_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_sessions_on_program_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.datetime "deleted_at"
    t.bigint "category_id", null: false
    t.bigint "session_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_units_on_category_id"
    t.index ["session_id"], name: "index_units_on_session_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "fullname"
    t.string "phone"
    t.string "avatar"
    t.string "language"
    t.string "status"
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "refresh_token"
  end

  add_foreign_key "categories", "sessions"
  add_foreign_key "lessons", "categories"
  add_foreign_key "lessons", "sessions"
  add_foreign_key "lessons", "units"
  add_foreign_key "presentations", "lessons"
  add_foreign_key "resources", "lessons"
  add_foreign_key "sessions", "programs"
  add_foreign_key "units", "categories"
  add_foreign_key "units", "sessions"
end
