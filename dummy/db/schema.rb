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

ActiveRecord::Schema.define(version: 20160606215417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "fuzzystrmatch"

  create_table "budget_accounts", force: :cascade do |t|
    t.string   "name",                       null: false
    t.boolean  "debt",       default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "budget_categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name",                           null: false
    t.integer  "lft",                            null: false
    t.integer  "rgt",                            null: false
    t.integer  "depth"
    t.integer  "budgeted_cents"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "watched",        default: false
  end

  add_index "budget_categories", ["depth"], name: "index_budget_categories_on_depth", using: :btree
  add_index "budget_categories", ["lft"], name: "index_budget_categories_on_lft", using: :btree
  add_index "budget_categories", ["parent_id"], name: "index_budget_categories_on_parent_id", using: :btree
  add_index "budget_categories", ["rgt"], name: "index_budget_categories_on_rgt", using: :btree

  create_table "budget_import_services", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "type",                       null: false
    t.boolean  "active",     default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "budget_importable_accounts", force: :cascade do |t|
    t.string   "source_id",   null: false
    t.integer  "imported_id"
    t.string   "name",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "budget_importable_accounts", ["source_id"], name: "index_budget_importable_accounts_on_source_id", unique: true, using: :btree

  create_table "budget_importable_categories", force: :cascade do |t|
    t.integer  "imported_id",              null: false
    t.string   "name",                     null: false
    t.integer  "import_count", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "budget_importable_transactions", force: :cascade do |t|
    t.string   "source_id",   null: false
    t.integer  "imported_id"
    t.date     "date",        null: false
    t.string   "description"
    t.string   "category"
    t.integer  "cents",       null: false
    t.boolean  "expense",     null: false
    t.string   "account"
    t.string   "account_id"
    t.string   "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "budget_importable_transactions", ["source_id"], name: "index_budget_importable_transactions_on_source_id", unique: true, using: :btree

  create_table "budget_preferences", force: :cascade do |t|
    t.integer  "owner_id",   null: false
    t.string   "owner_type", null: false
    t.string   "key",        null: false
    t.text     "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budget_transactions", force: :cascade do |t|
    t.integer  "account_id",           null: false
    t.integer  "category_id",          null: false
    t.integer  "transfer_id"
    t.string   "type",                 null: false
    t.date     "date",                 null: false
    t.string   "description",          null: false
    t.integer  "cents",                null: false
    t.string   "notes"
    t.integer  "split_transaction_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "budget_transactions", ["account_id"], name: "index_budget_transactions_on_account_id", using: :btree
  add_index "budget_transactions", ["category_id"], name: "index_budget_transactions_on_category_id", using: :btree
  add_index "budget_transactions", ["split_transaction_id"], name: "index_budget_transactions_on_split_transaction_id", using: :btree
  add_index "budget_transactions", ["transfer_id"], name: "index_budget_transactions_on_transfer_id", using: :btree

  add_foreign_key "budget_categories", "budget_categories", column: "parent_id"
  add_foreign_key "budget_importable_accounts", "budget_accounts", column: "imported_id"
  add_foreign_key "budget_importable_categories", "budget_categories", column: "imported_id"
  add_foreign_key "budget_importable_transactions", "budget_importable_accounts", column: "account_id", primary_key: "source_id"
  add_foreign_key "budget_importable_transactions", "budget_transactions", column: "imported_id"
  add_foreign_key "budget_transactions", "budget_accounts", column: "account_id"
  add_foreign_key "budget_transactions", "budget_categories", column: "category_id"
  add_foreign_key "budget_transactions", "budget_transactions", column: "split_transaction_id"
  add_foreign_key "budget_transactions", "budget_transactions", column: "transfer_id"
end
