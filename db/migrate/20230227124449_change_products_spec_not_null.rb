class ChangeProductsSpecNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :spec, false
  end
end
