class ChangeProductsIsOriginalNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :is_original, false
  end
end
