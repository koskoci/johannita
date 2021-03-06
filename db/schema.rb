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

ActiveRecord::Schema.define(version: 2019_02_10_142221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "description"
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "course_event_id", null: false
    t.bigint "participant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_event_id", "participant_id"], name: "index_attendances_on_course_event_id_and_participant_id", unique: true
    t.index ["course_event_id"], name: "index_attendances_on_course_event_id"
    t.index ["participant_id"], name: "index_attendances_on_participant_id"
  end

  create_table "course_categories", force: :cascade do |t|
    t.date "last_date"
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "prerequisite_course_category_id"
  end

  create_table "course_events", force: :cascade do |t|
    t.string "title"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id", null: false
    t.index ["course_id"], name: "index_course_events_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.date "apply_by", null: false
    t.string "title"
    t.string "status", default: "posted", null: false
    t.bigint "course_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_participants", default: 20
    t.index ["course_category_id"], name: "index_courses_on_course_category_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "short_name"
    t.text "content"
    t.index ["short_name"], name: "index_pages_on_short_name", unique: true
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "attended"
    t.boolean "passed"
    t.bigint "course_id", null: false
    t.index ["course_id", "user_id"], name: "idx_course_user_unique", unique: true
    t.index ["course_id"], name: "index_participants_on_course_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "thumbnail_url", null: false
    t.string "blurb"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.date "pav_until"
    t.date "driving_licence_since"
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "attendances", "course_events"
  add_foreign_key "attendances", "participants"
  add_foreign_key "course_events", "courses"
  add_foreign_key "courses", "course_categories"
  add_foreign_key "participants", "courses", on_delete: :cascade
  add_foreign_key "participants", "users"
end
