class Product < ApplicationRecord
  #商品のモデル 中間モデルprocut_supplierを通して仕入れ先supplierモデルを取得する
  has_many :product_suppliers
  has_many :suppliers, through: :product_suppliers
  has_many :prices, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :code
    validates :catalog_page_number
    validates :spec
    #validates :is_original
  end
end
