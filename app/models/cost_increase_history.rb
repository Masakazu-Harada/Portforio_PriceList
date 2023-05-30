class CostIncreaseHistory < ApplicationRecord
  belongs_to :product_supplier
  belongs_to :user

  after_save :update_product_supplier_cost

  private

  def update_product_supplier_cost
    #前提としてバックグラウンドジョブを毎日決まった時間に行うとして、ここで値上げ予定日が今日またはそれ以前であった場合、
    #after_saveが発動し、update_product_supplier_cost実行され、ProductSupplierモデルにもある、
    #current_costが更新され最新の仕入原価が反映される実装。
    if cost_revision_date <= Date.today
      product_supplier.update(current_cost: current_cost)
    end
  end
end
