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

ActiveRecord::Schema.define(version: 20160808080030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.string   "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "apps", force: :cascade do |t|
    t.string   "name",                             null: false
    t.string   "ssh_key"
    t.integer  "user_id",                          null: false
    t.integer  "exercise_id"
    t.datetime "reviewed_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "exercise_points",  default: 0
    t.integer  "review_points",    default: 0,     null: false
    t.string   "course",                           null: false
    t.boolean  "external_hosting", default: false
    t.string   "external_url"
  end

  create_table "exercise_results", force: :cascade do |t|
    t.integer  "app_id",      null: false
    t.integer  "exercise_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "message"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text     "body"
    t.integer  "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "groups_users", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "user_id",  null: false
  end

  create_table "review_dates", force: :cascade do |t|
    t.integer  "review_group_id",                null: false
    t.datetime "begins_at",                      null: false
    t.integer  "exercise_id",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "length_in_minutes", default: 10, null: false
    t.datetime "reviewed_at"
    t.integer  "review_points",     default: 0,  null: false
    t.integer  "user_id"
  end

  add_index "review_dates", ["review_group_id", "exercise_id"], name: "index_review_dates_on_review_group_id_and_exercise_id", unique: true, using: :btree

  create_table "review_groups", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order",      default: 0, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "name",                   default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "ssh_key",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "blocked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "course"
    t.integer  "review_group_id"
    t.datetime "reviewed_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "feedbacks", "apps"
end
