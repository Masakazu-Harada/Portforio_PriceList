class ProductSupplier < ApplicationRecord
  #多(productモデル) 対 多(supplierモデル)の中間モデル
  belongs_to :product
  belongs_to :supplier
  has_many :cost_increase_histories, dependent: :destroy

  def update_cost_if_needed
    if price_revision_date.present? && future_cost.present? && price_revision_date <= Date.today
      price_increase_histories.create!(
        price_revision_date: price_revision_date,
        old_cost: current_cost,
        new_cost: future_cost
      )

      self.current_cost = future_cost
      self.price_revision_date = nil
      self.future_cost = nil
      save!
    end
  end

  def cost
    update_cost_if_needed
    if price_revision_date.present? && price_revision_date <= Date.today
      future_cost
    else
      current_cost
    end
  end
end
