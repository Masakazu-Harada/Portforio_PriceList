class ChangeUnitToEnumInProducts < ActiveRecord::Migration[6.0]
  def up
    # 新しい一時的なカラムを追加
    add_column :products, :new_unit, :integer, default: 0

    # 元のunitカラムのデータを新しいenum形式に変換して一時的なカラムに保存
    Product.reset_column_information
    Product.find_each do |product|
      product.update_columns(new_unit: Product.units[product.unit])
    end

    # 元のunitカラムを削除
    remove_column :products, :unit

    # 一時的なカラムの名前をunitに変更
    rename_column :products, :new_unit, :unit
  end

  def down
    # カラムの名前を元に戻す
    rename_column :products, :unit, :new_unit

    # 元のunitカラムを再度追加
    add_column :products, :unit, :string

    # 一時的なカラムのデータを元の形式に変換してunitカラムに保存
    Product.reset_column_information
    Product.find_each do |product|
      product.update_columns(unit: Product.units.key(product.new_unit))
    end

    # 一時的なカラムを削除
    remove_column :products, :new_unit
  end
end
