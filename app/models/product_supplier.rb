class ProductSupplier < ApplicationRecord
  #多(productモデル) 対 多(supplierモデル)の中間モデル
  attr_accessor :cost_revision_date, :future_cost
  
  belongs_to :product
  belongs_to :supplier
  has_many :cost_increase_histories, dependent: :destroy

  after_save :create_cost_history, if: :cost_update?
  after_save :notify_future_cost, if: :future_cost_set?

  def latest_cost
    cost_increase_histories.order(id: :desc).where("cost_revision_date <= ?" , Date.today).first&.new_cost
  end

  private

  def cost_update?
    future_cost.present? && cost_revision_date.present?
  end

  def future_cost_set?
    Date.parse(cost_revision_date) > Date.today if cost_revision_date.present?
  end

  def create_cost_history
    cost_increase_histories.create(new_cost: future_cost, cost_revision_date: cost_revision_date )
  end

  def notify_future_cost
    # ここで未来のコスト通知ロジックを実装します
  end
end
