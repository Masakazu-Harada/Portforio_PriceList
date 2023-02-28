class Product < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :code
    validates :catalog_page_number
    validates :spec
    validates :is_original
  end
end
