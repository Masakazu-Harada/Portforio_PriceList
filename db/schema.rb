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

ActiveRecord::Schema[7.0].define(version: 2023_06_19_143353) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affiliations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_affiliations_on_department_id"
    t.index ["user_id"], name: "index_affiliations_on_user_id"
  end

  create_table "cost_increase_histories", force: :cascade do |t|
    t.bigint "product_supplier_id", null: false
    t.date "cost_revision_date"
    t.integer "current_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["product_supplier_id"], name: "index_cost_increase_histories_on_product_supplier_id"
    t.index ["user_id"], name: "index_cost_increase_histories_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "rank_id", null: false
    t.string "name"
    t.text "share"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rank_id"], name: "index_customers_on_rank_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
  end

  create_table "price_change_histories", force: :cascade do |t|
    t.bigint "price_id", null: false
    t.bigint "user_id", null: false
    t.integer "old_price"
    t.integer "new_price"
    t.date "change_price_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_id"], name: "index_price_change_histories_on_price_id"
    t.index ["user_id"], name: "index_price_change_histories_on_user_id"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "rank_id", null: false
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "updated_by_user_id"
    t.integer "user_id"
    t.integer "created_by_user_id"
    t.integer "future_price"
    t.date "price_increase_date"
    t.index ["created_by_user_id"], name: "index_prices_on_created_by_user_id"
    t.index ["product_id", "rank_id"], name: "index_prices_on_product_id_and_rank_id", unique: true
    t.index ["product_id"], name: "index_prices_on_product_id"
    t.index ["rank_id"], name: "index_prices_on_rank_id"
    t.index ["user_id"], name: "index_prices_on_user_id"
  end

  create_table "product_suppliers", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_cost"
    t.integer "future_cost"
    t.date "cost_revision_date"
    t.index ["product_id"], name: "index_product_suppliers_on_product_id"
    t.index ["supplier_id"], name: "index_product_suppliers_on_supplier_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.integer "catalog_page_number", null: false
    t.string "spec", null: false
    t.boolean "is_original", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "carton"
    t.boolean "is_separate", default: false
    t.string "location"
    t.string "due_date"
    t.boolean "same_day_shipping", default: false
    t.string "shipping_rate"
    t.string "hokkaido_shipping_rate"
    t.string "notes"
    t.integer "prepayment"
    t.integer "status", default: 0
    t.integer "unit", default: 0
  end

  create_table "ranks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "closing_time"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "phone_number"
    t.string "spec"
    t.integer "shipping_unit"
    t.string "unit"
    t.integer "prepayment_unit"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "user_type", default: "employee"
    t.integer "customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "affiliations", "departments"
  add_foreign_key "affiliations", "users"
  add_foreign_key "cost_increase_histories", "product_suppliers"
  add_foreign_key "cost_increase_histories", "users"
  add_foreign_key "customers", "ranks"
  add_foreign_key "price_change_histories", "prices"
  add_foreign_key "price_change_histories", "users"
  add_foreign_key "prices", "products"
  add_foreign_key "prices", "ranks"
  add_foreign_key "product_suppliers", "products"
  add_foreign_key "product_suppliers", "suppliers"
end
