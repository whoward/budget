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

ActiveRecord::Schema.define(version: 20151111055553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "fuzzystrmatch"
  enable_extension "pg_trgm"

  create_table "budget_accounts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "debt",                   default: false
  end

  create_table "budget_categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "budgeted_cents"
  end

  add_index "budget_categories", ["depth"], name: "index_budget_categories_on_depth", using: :btree
  add_index "budget_categories", ["lft"], name: "index_budget_categories_on_lft", using: :btree
  add_index "budget_categories", ["parent_id"], name: "index_budget_categories_on_parent_id", using: :btree
  add_index "budget_categories", ["rgt"], name: "index_budget_categories_on_rgt", using: :btree

  create_table "budget_import_services", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "type",       limit: 255
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_importable_accounts", force: :cascade do |t|
    t.string   "source_id",   limit: 255
    t.integer  "imported_id"
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "budget_importable_accounts", ["source_id"], name: "index_budget_importable_accounts_on_source_id", unique: true, using: :btree

  create_table "budget_importable_categories", force: :cascade do |t|
    t.integer  "imported_id"
    t.string   "name",         limit: 255
    t.integer  "import_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_importable_transactions", force: :cascade do |t|
    t.string   "source_id",   limit: 255
    t.integer  "imported_id"
    t.date     "date"
    t.string   "description", limit: 255
    t.string   "category",    limit: 255
    t.integer  "cents"
    t.boolean  "expense"
    t.string   "account",     limit: 255
    t.integer  "account_id"
    t.string   "notes",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "budget_importable_transactions", ["source_id"], name: "index_budget_importable_transactions_on_source_id", unique: true, using: :btree

  create_table "budget_preferences", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type", limit: 255
    t.string   "key",        limit: 255
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_transactions", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "category_id"
    t.integer  "transfer_id"
    t.string   "type",                 limit: 255
    t.date     "date"
    t.string   "description",          limit: 255
    t.integer  "cents"
    t.string   "notes",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "split_transaction_id"
  end

  add_index "budget_transactions", ["account_id"], name: "index_budget_transactions_on_account_id", using: :btree
  add_index "budget_transactions", ["category_id"], name: "index_budget_transactions_on_category_id", using: :btree
  add_index "budget_transactions", ["transfer_id"], name: "index_budget_transactions_on_transfer_id", using: :btree

end
