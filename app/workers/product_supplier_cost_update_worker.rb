class ProductSupplierCostUpdateWorker
  include Sidekiq::Worker

  def perform(product_supplier_id)
    product_supplier = ProductSupplier.find_by(id: product_supplier_id)

    return unless product_supplier

    # ここで ProductSupplier モデルのコスト更新ロジックを実行する。
    product_supplier.update_cost
  end
end
