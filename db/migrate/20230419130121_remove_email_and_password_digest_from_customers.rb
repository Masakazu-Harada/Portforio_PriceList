class RemoveEmailAndPasswordDigestFromCustomers < ActiveRecord::Migration[7.0]
  def up
    remove_column :customers, :email
    remove_column :customers, :password_digest
  end

  def down
    add_column :customers, :email, :string
    add_column :customers, :password_digest, :string
  end
end
