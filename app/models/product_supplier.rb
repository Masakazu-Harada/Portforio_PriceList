class ProductSupplier < ApplicationRecord
  #多(productモデル) 対 多(supplierモデル)の中間モデル
  belongs_to :product
  belongs_to :supplier
end
