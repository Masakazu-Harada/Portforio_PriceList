class Supplier < ApplicationRecord
  #仕入れ先の情報の入ったモデル 中間モデルのproduct_supplierモデルを通してproductモデルかから商品情報を取得する
  has_many :product_suppliers
  has_many :products, through: :product_suppliers 

  with_options presence: true do
    validates :name #仕入れ先名
    validates :purchasing_cost #仕入原価
    validates :price_revision_date #値上げ開始日
    validates :raise_price #値上げ単価
    validates :minimum_shipping_unit #最低出荷単位
    validates :prepayshipping_unit #送料元払い数量
  end
end
