class PriceChangeHistory < ApplicationRecord
  belongs_to :price
  belongs_to :user
  belongs_to :product
end
