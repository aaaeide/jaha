# frozen_string_literal: true

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

ActiveRecord::Schema[7.1].define(version: 20_240_909_055_020) do
  create_table 'shows', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_shows_on_name', unique: true
  end

  create_table 'user_shows', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'show_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['show_id'], name: 'index_user_shows_on_show_id'
    t.index ['user_id'], name: 'index_user_shows_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username', null: false
    t.string 'email', null: false
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'password_digest', default: '', null: false
  end

  add_foreign_key 'user_shows', 'shows'
  add_foreign_key 'user_shows', 'users'
end
