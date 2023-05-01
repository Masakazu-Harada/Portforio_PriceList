class AddPositionToDepartments < ActiveRecord::Migration[7.0]
  def change
    add_column :departments, :position, :integer
  end
end
