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

ActiveRecord::Schema.define(version: 20151117051519) do

  create_table "assignments", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "assignments", ["project_id"], name: "index_assignments_on_project_id", using: :btree
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id", using: :btree

  create_table "issues", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "priority",    limit: 4
    t.date     "deadline"
    t.integer  "status",      limit: 4
    t.integer  "project_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "issues", ["project_id"], name: "index_issues_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "project_name",    limit: 255
    t.datetime "start_date"
    t.datetime "target_end_date"
    t.datetime "final_end_date"
    t.string   "created_by",      limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "user_issues", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "issue_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_issues", ["issue_id"], name: "index_user_issues_on_issue_id", using: :btree
  add_index "user_issues", ["user_id"], name: "index_user_issues_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "assignments", "projects"
  add_foreign_key "assignments", "users"
  add_foreign_key "issues", "projects"
  add_foreign_key "user_issues", "issues"
  add_foreign_key "user_issues", "users"
end
