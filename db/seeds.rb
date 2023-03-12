# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

departments = [
  {name: "購買部"},
  {name: "営業部"},
  {name: "管理部"},
  {name: "業務部"},
]

Department.insert_all(departments)

ranks = [
  {name: "問屋"},
  {name: "販売店"},
  {name: "その他"},
  {name: "末端"},
]

Rank.insert_all(ranks)
