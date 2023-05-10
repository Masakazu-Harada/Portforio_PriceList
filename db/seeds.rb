# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

departments = [
  {name: "東日本営業課", position: 1},
  {name: "西日本営業課", position: 2},
  {name: "購買課", position: 3},
  {name: "業務課", position: 4},
  {name: "管理課", position: 5},
  {name: "物流課", position: 6},
  {name: "営業推進課", position: 7},
]

departments.each do |v|
  department = Department.find_or_initialize_by(name: v[:name])
  department.assign_attributes(position: v[:position])
  department.save!
end

# 商品と仕入先のサンプルデータを作成
product = Product.create!(name: "Sample Product", code: "SP-01", catalog_page_number: 1, spec: "10cm")
supplier = Supplier.create!(name: "Sample Supplier", address: "Sample Address", phone_number: "000-0000-0000")

ranks = [
  {name: "問屋"},
  {name: "販売店"},
  {name: "その他"},
  {name: "末端"},
]

ranks.each do |v|
  rank = Rank.find_or_initialize_by(name: v[:name])
  rank.save!
end

admin_user = {
  name: "原田 勝利", # 管理者ユーザー名
  email: "seungri.uhm@gmail.com",
  password: "password", # 実際のパスワードに置き換えてください
  password_confirmation: "password", # 実際のパスワードに置き換えてください
  admin: true
}

user = User.find_or_initialize_by(email: admin_user[:email])
user.assign_attributes(admin_user)
user.save!

puts "Finish db:seed"

# 商品と仕入先の関連データを作成
product_supplier = ProductSupplier.create!(product_id: product.id, supplier_id: supplier.id)

# 価格改定履歴のデータを作成
# previous_cost = 100
# current_cost = 150
#
# PriceIncreaseHistory.create!(
#   product_supplier_id: product_supplier.id,
#   price_revision_date: Date.today,
#   old_cost: previous_cost,
#   new_cost: current_cost
# )
