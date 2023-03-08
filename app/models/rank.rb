class Rank < ApplicationRecord
  #問屋 販売店 その他 末端の４つのnameカラムを持つモデル priceモデルのカラムpriceにこの４つのレコードを紐づける
  has_many :prices
  has_many :products, through: :prices
  has_many :customers
end
