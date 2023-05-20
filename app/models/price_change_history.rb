class PriceChangeHistory < ApplicationRecord
  belongs_to :price
  belongs_to :user, optional: true
  belongs_to :product
end
