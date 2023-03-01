class ChangeProductsCatalogPageNumberNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :catalog_page_number, false
  end
end
