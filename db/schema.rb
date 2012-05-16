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

ActiveRecord::Schema.define(:version => 20120516171244) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "pub_key"
  end

  add_index "accounts", ["pub_key"], :name => "index_accounts_on_pub_key", :unique => true
  add_index "accounts", ["subdomain"], :name => "index_accounts_on_subdomain", :unique => true

  create_table "members", :force => true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "pub_key"
  end

  add_index "members", ["account_id", "user_id"], :name => "index_members_on_account_id_and_user_id", :unique => true
  add_index "members", ["account_id"], :name => "index_members_on_account_id"
  add_index "members", ["pub_key"], :name => "index_members_on_pub_key", :unique => true
  add_index "members", ["user_id"], :name => "index_members_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "pub_key"
    t.string   "password_digest"
  end

  add_index "users", ["pub_key"], :name => "index_users_on_pub_key", :unique => true

end
