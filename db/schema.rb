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

ActiveRecord::Schema.define(version: 20130819173421) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "about"
    t.string   "location"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "season_id"
  end

  add_index "events", ["season_id"], name: "index_events_on_season_id"

  create_table "matchups", force: true do |t|
    t.integer  "event_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matchups", ["event_id"], name: "index_matchups_on_event_id"
  add_index "matchups", ["team_id"], name: "index_matchups_on_team_id"

  create_table "members", force: true do |t|
    t.integer  "user_id"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "groupable_id"
    t.string   "groupable_type"
  end

  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "about"
    t.string   "location"
    t.string   "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "organizations", ["slug"], name: "index_organizations_on_slug", unique: true

  create_table "seasons", force: true do |t|
    t.integer  "organization_id"
    t.string   "name",                           null: false
    t.date     "start"
    t.date     "end"
    t.boolean  "members_allowed", default: true, null: false
    t.integer  "max_members"
    t.boolean  "teams_allowed",   default: true, null: false
    t.integer  "max_teams"
    t.integer  "max_team_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["organization_id"], name: "index_seasons_on_organization_id"

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "rank"
    t.integer  "max_members"
    t.integer  "season_id"
  end

  add_index "teams", ["season_id"], name: "index_teams_on_season_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "phone"
    t.string   "address"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
