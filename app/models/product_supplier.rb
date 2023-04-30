class ProductSupplier < ApplicationRecord
  #多(productモデル) 対 多(supplierモデル)の中間モデル
  belongs_to :product
  belongs_to :supplier

  def update_cost_if_needed
    if price_revision_date.present? && future_cost.present? && price_revision_date == Date.today
      self.current_cost = future_cost
      self.price_revision_date = nil
      self.future_cost = nil
      save
    end
  end

  def cost
    if price_revision_date.present? && price_revision_date == Date.today
      future_cost
    else
      current_cost
    end
  end
end
