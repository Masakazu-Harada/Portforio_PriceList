ActiveRecord::Schema[7.0].define(version: 2023_04_19_130121) do
  create_table "affiliations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_affiliations_on_department_id"
    t.index ["user_id"], name: "index_affiliations_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.integer "rank_id", null: false
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
  end

  create_table "prices", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "rank_id", null: false
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_prices_on_product_id"
    t.index ["rank_id"], name: "index_prices_on_rank_id"
  end

  create_table "product_suppliers", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost"
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
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "affiliations", "departments"
  add_foreign_key "affiliations", "users"
  add_foreign_key "customers", "ranks"
  add_foreign_key "prices", "products"
  add_foreign_key "prices", "ranks"
  add_foreign_key "product_suppliers", "products"
  add_foreign_key "product_suppliers", "suppliers"
end
