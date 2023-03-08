ActiveRecord::Schema[7.0].define(version: 2023_03_07_131539) do
  create_table "affiliations", force: :cascade do |t| #User社員とDepartment部署を繋ぐ中間モデル
    t.integer "user_id", null: false
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_affiliations_on_department_id"
    t.index ["user_id"], name: "index_affiliations_on_user_id"
  end

  create_table "customers", force: :cascade do |t| #顧客Customerモデル 親モデルとしてRankモデルがありrankカラムを所持する
    t.integer "rank_id", null: false
    t.string "name" #顧客名
    t.text "share" #引き継ぎ事項を記入するコメント欄だけの機能
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rank_id"], name: "index_customers_on_rank_id"
  end

  create_table "departments", force: :cascade do |t| #部署Departmentモデル 中間モデルaffiliationsを通してUserモデルと繋がる
    t.string "name" #部署名
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", force: :cascade do |t| #商品ProductモデルとRankモデルを繋げる中間モデルでありpriceカラムに価格を格納している
    t.integer "product_id", null: false
    t.integer "rank_id", null: false
    t.integer "price" #価格を入れる
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_prices_on_product_id"
    t.index ["rank_id"], name: "index_prices_on_rank_id"
  end

  create_table "product_suppliers", force: :cascade do |t| #仕入れ先モデルsupplierと商品モデルproductを繋げる中間モデル
    t.integer "product_id", null: false
    t.integer "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_suppliers_on_product_id"
    t.index ["supplier_id"], name: "index_product_suppliers_on_supplier_id"
  end

  create_table "products", force: :cascade do |t| #商品モデル
    t.string "name", null: false #商品名
    t.string "code", null: false #商品コード
    t.integer "catalog_page_number", null: false #カタログのページ
    t.string "spec", null: false #サイズ・規格
    t.boolean "is_original", default: false, null: false #オリジナルか仕入れ商品か判定
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ranks", force: :cascade do |t| #販売価格帯の４つのランクモデル
    t.string "name" #問屋 販売店 その他 末端の４つのレコードを所持する
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t| #仕入れ先モデル
    t.string "name" #仕入れ先名称
    t.integer "purchasing_cost" #仕入れ原価
    t.date "price_revision_date" #値上げ開始日
    t.integer "raise_price" #値上げ後の単価
    t.integer "minimum_shipping_unit" #最低出荷単位
    t.integer "prepayshipping_unit" #送料元払いの数量
    t.string "location" #出荷場所
    t.string "closing_time" #出荷締め時間
    t.string "note" #備考欄主に送料とかのメモ書き
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t| #社員のUserモデル
    t.string "name", null: false #社員名
    t.string "email", null: false #メール
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false #管理者権限の判定
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
