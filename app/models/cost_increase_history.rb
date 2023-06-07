class CostIncreaseHistory < ApplicationRecord
  belongs_to :product_supplier
  belongs_to :user

  after_save :schedule_product_supplier_cost_update

  private

  def schedule_product_supplier_cost_update
    # 値上げ予定日が未来の日付である場合、ProductSupplierCostUpdateWorkerをその日付にスケジュールする。
    # それ以外の場合（値上げ予定日が今日またはそれ以前、もしくはnil）、すぐにProductSupplierのcostを更新する。
    if cost_revision_date.present? && cost_revision_date > Date.today
      UpdateProductSupplierCostsJob.set(wait_until: cost_revision_date.beginning_of_day).perform_later(product_supplier_id)
      product_supplier.update_cost
    end
  end
end
