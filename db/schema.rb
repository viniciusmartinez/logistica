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

ActiveRecord::Schema.define(:version => 20120803014710) do

  create_table "adjunct_cities", :force => true do |t|
    t.string   "city_id"
    t.integer  "kms_de_cuiaba"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "bio"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "event_id"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "mobile"
    t.string   "occupation"
    t.text     "address"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.date     "birthday"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "rank",            :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "name_normalized"
    t.boolean  "favorite",        :default => false
  end

  create_table "elections", :force => true do |t|
    t.string   "nome"
    t.string   "nome_abreviado"
    t.string   "election_date_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.datetime "base_em"
  end

  create_table "electoral_models", :force => true do |t|
    t.integer  "electoral_unit_id"
    t.integer  "electronic_ballot_box_model_id"
    t.integer  "qtd"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "election_id"
  end

  create_table "electoral_places", :force => true do |t|
    t.integer  "electoral_unit_id"
    t.string   "place_id"
    t.integer  "secoes"
    t.integer  "agregacoes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "electoral_places", ["electoral_unit_id"], :name => "index_electoral_places_on_electoral_unit_id"

  create_table "electoral_units", :force => true do |t|
    t.integer  "election_id"
    t.string   "city_id"
    t.string   "zone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "agregacoes"
    t.integer  "ues_de_secao"
    t.integer  "ues_de_contingencia"
    t.integer  "eleitorado"
    t.integer  "mrjs_atendidas"
    t.text     "modelos_de_ue"
    t.boolean  "sede"
    t.integer  "mrjs_solicitadas",    :default => 0
    t.boolean  "excecao_mrj",         :default => false, :null => false
    t.boolean  "bio"
  end

  create_table "electronic_ballot_box_models", :force => true do |t|
    t.integer  "qtd"
    t.boolean  "bio"
    t.integer  "ano"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ativo"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "all_day",     :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.text     "name"
    t.datetime "date"
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preferences", :force => true do |t|
    t.boolean  "email_task_alert",      :default => false
    t.boolean  "email_birthday_alert",  :default => false
    t.string   "weather_location"
    t.string   "weather_location_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "protocols", :force => true do |t|
    t.integer  "numero"
    t.date     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suit_status_changes", :force => true do |t|
    t.datetime "momento"
    t.integer  "status"
    t.text     "comentario"
    t.integer  "suit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suits", :force => true do |t|
    t.string   "entidade"
    t.string   "representante"
    t.integer  "protocol_id"
    t.integer  "status_decisao"
    t.integer  "status_atendimento"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.text     "name"
    t.datetime "due_at"
    t.boolean  "completed",  :default => false
    t.integer  "priority"
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "name"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "address"
    t.integer  "address_number"
    t.string   "address_extra"
    t.string   "neighborhood"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.string   "gender",             :limit => 1
    t.string   "phone"
    t.string   "mobile"
    t.boolean  "admin",                           :default => false
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.string   "current_login_at"
    t.string   "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
