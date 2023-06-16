class AddDefaultStatusToProducts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :products, :status, from: nil, to: 0
  end
end
