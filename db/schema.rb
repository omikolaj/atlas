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

ActiveRecord::Schema.define(version: 20171203103200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "topLevelDomain"
    t.string "alpha2Code"
    t.string "alpha3Code"
    t.string "callingCodes"
    t.string "capital"
    t.string "region"
    t.string "subregion"
    t.string "demonym"
    t.float  "area"
    t.string "timezones"
    t.string "borders"
    t.string "nativeName"
    t.string "currency_name"
    t.string "currency_symbol"
    t.string "native_lang_name"
    t.string "language_name"
    t.string "flag_path"
  end

  create_table "user_countries", force: :cascade do |t|
    t.integer "user_id"
    t.integer "country_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
  end

end
