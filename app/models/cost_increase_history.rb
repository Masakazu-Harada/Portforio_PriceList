class CostIncreaseHistory < ApplicationRecord
  belongs_to :product_supplier
  belongs_to :user
end
