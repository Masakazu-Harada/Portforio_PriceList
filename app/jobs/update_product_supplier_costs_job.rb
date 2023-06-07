class UpdateProductSupplierCostsJob < ApplicationJob
  queue_as :default

  def perform(product_supplier_id)
    # cost_revision_dateが今日または過去の全てのProductSupplierエントリを見つける
    # そして効率のためにバッチ処理する
    ProductSupplier.where('cost_revision_date <= ?', Date.today).find_each do |ps|
      # CostIncreaseHistoryモデルに新しいエントリを作成する
      CostIncreaseHistory.create(product_supplier_id: ps.id, cost_revision_date: ps.cost_revision_date, current_cost: ps.future_cost)

      # future_costをcurrent_costに移動し、future_costとcost_revision_dateをnilに設定する
      ps.update(current_cost: ps.future_cost, future_cost: nil, cost_revision_date: nil)
    end
  end
end
