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

ActiveRecord::Schema.define(:version => 20120317104020) do

  create_table "profiles", :force => true do |t|
    t.string "name",        :limit => 30
    t.string "wave_models", :limit => 45
  end

  create_table "profiles_stations", :id => false, :force => true do |t|
    t.integer "station_id", :null => false
    t.integer "profile_id", :null => false
  end

  create_table "readings", :force => true do |t|
    t.datetime "created_at"
    t.integer  "station_id"
    t.string   "wdir",              :limit => 20
    t.string   "wspd",              :limit => 20
    t.string   "wvht",              :limit => 20
    t.string   "dpd",               :limit => 20
    t.string   "apd",               :limit => 20
    t.string   "pres",              :limit => 20
    t.string   "ptdy",              :limit => 20
    t.string   "atmp",              :limit => 20
    t.string   "wtmp",              :limit => 20
    t.string   "mwd",               :limit => 20
    t.string   "timeof_conditions", :limit => 35
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_joins", :force => true do |t|
    t.integer  "station_id"
    t.integer  "profile_id"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", :force => true do |t|
    t.string "number",       :limit => 30
    t.string "name",         :limit => 40
    t.string "area",         :limit => 2
    t.string "weight",       :limit => 2
    t.string "wave_model",   :limit => 20
    t.string "description"
    t.string "geo_location"
  end

  create_table "surfcasts", :force => true do |t|
    t.datetime "created_at"
    t.integer  "station_id"
    t.integer  "day"
    t.integer  "hour"
    t.integer  "direction"
    t.float    "height"
    t.float    "period"
  end

  create_table "tide_readings", :force => true do |t|
    t.integer  "weather_location_id"
    t.string   "day"
    t.string   "hour"
    t.string   "event"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weather_locations", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tide_key"
  end

  create_table "weather_readings", :force => true do |t|
    t.integer  "weather_location_id"
    t.string   "hour"
    t.string   "temp"
    t.integer  "precip"
    t.string   "wind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
