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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120424181707) do

  create_table "materials", :force => true do |t|
    t.integer  "material_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "status"
    t.string   "comment"
    t.integer  "count"
    t.decimal  "duration"
    t.decimal  "distance_km"
    t.datetime "lastchange"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "materials", ["user_id", "material_id"], :name => "index_materials_on_user_id_and_material_id", :unique => true

  create_table "routes", :force => true do |t|
    t.integer  "route_id"
    t.string   "name"
    t.decimal  "km"
    t.string   "gpsies"
    t.text     "comment"
    t.datetime "lastchanged"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "routes", ["gpsies"], :name => "index_routes_on_gpsies"
  add_index "routes", ["route_id"], :name => "index_routes_on_route_id"

  create_table "routes_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "route_id"
  end

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.string   "comment"
    t.datetime "lastchange"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "sport_id"
  end

  add_index "sports", ["sport_id"], :name => "index_sports_on_sport_id"

  create_table "sports_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "sport_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.string   "nickname"
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
