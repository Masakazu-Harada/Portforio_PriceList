class ChangePrepaymentTypeInProducts < ActiveRecord::Migration[7.0]
  def up
    change_column :products, :prepayment, 'integer USING CAST(prepayment AS integer)'
  end

  def down
    change_column :products, :prepayment, :string
  end
end
