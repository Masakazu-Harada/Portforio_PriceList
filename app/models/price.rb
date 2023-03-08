class Price < ApplicationRecord
  #priceカラムを持つ中間モデル 多(productモデル) 対 多(rankモデル)
  belongs_to :product
  belongs_to :rank
end
