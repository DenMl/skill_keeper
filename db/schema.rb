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

ActiveRecord::Schema.define(version: 20150731150002) do

  create_table "candidate_to_skill_relationships", force: true do |t|
    t.integer  "candidate_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidate_to_skill_relationships", ["skill_id", "candidate_id"], name: "index_candidate_id_to_skill_id", unique: true

  create_table "candidates", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "patronymic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidates", ["first_name", "last_name", "patronymic"], name: "index_candidates_on_first_name_and_last_name_and_patronymic", unique: true

  create_table "report_template_to_skill_group_relationships", force: true do |t|
    t.integer  "report_template_id"
    t.integer  "skill_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_templates", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "report_templates", ["name"], name: "index_report_templates_on_name", unique: true

  create_table "skill_group_to_skill_relationships", force: true do |t|
    t.integer  "skill_group_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skill_group_to_skill_relationships", ["skill_id", "skill_group_id"], name: "index_skill_group_id_to_skill_id", unique: true

  create_table "skill_groups", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skill_groups", ["name"], name: "index_skill_groups_on_name", unique: true

  create_table "skills", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["name"], name: "index_skills_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
