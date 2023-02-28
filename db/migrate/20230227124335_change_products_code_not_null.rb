class ChangeProductsCodeNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :code, false
  end
end
