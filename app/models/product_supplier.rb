class ProductSupplier < ApplicationRecord
  attr_accessor :future_cost

  belongs_to :product
  belongs_to :supplier
  has_many :cost_increase_histories, dependent: :destroy

  def handle_cost_increase_history(cost_increase_history_params, user)
    cost_increase_history = cost_increase_histories.find_or_initialize_by(id: cost_increase_history_params[:id])
    cost_increase_history.assign_attributes(cost_increase_history_params)
    cost_increase_history.user = user

    if cost_increase_history.persisted?
      # 更新の場合
      self.future_cost = cost_increase_history_params[:current_cost]
    else
      # 新規作成の場合
      self.future_cost = cost_increase_history_params[:current_cost]
      cost_increase_history.cost_revision_date ||= Date.today
    end

    save && cost_increase_history.save
  end

  after_create :create_initial_cost_history
  after_update :handle_updated_cost_history, if: :cost_update?

  after_save :notify_future_cost, if: :future_cost_set?

  def display_cost_at_creation
    cost_increase_histories.order(id: :desc).first&.current_cost || "-"
  end

  def display_latest_cost
    cost_increase_histories.order(id: :desc).where("cost_revision_date <= ?" , Date.today).first&.current_cost || "-"
  end

  def display_next_scheduled_cost
    next_scheduled_cost || "-"
  end

  def display_next_scheduled_cost_revision_date
    next_scheduled_cost_revision_date || "-"
  end

  private

  def create_initial_cost_history
    create_cost_history if future_cost.present?
  end

  def handle_updated_cost_history
    create_cost_history if future_cost.present?
  end

  def create_cost_history
    cost_increase_histories.create(current_cost: future_cost)
  end

  def cost_update?
    future_cost.present?
  end

  def future_cost_set?
    cost_increase_histories.any? { |h| h.cost_revision_date.present? && h.cost_revision_date > Date.today }
  end

  def notify_future_cost
    # 未来のコスト通知ロジックをここで実装します
  end

  def next_scheduled_cost
    next_scheduled_history = future_cost_increase_history
    next_scheduled_history&.current_cost
  end

  def next_scheduled_cost_revision_date
    next_scheduled_history = future_cost_increase_history
    next_scheduled_history&.cost_revision_date
  end

  def future_cost_increase_history
    cost_increase_histories
      .where("cost_revision_date > ?", Date.today)
      .order(cost_revision_date: :asc)
      .first
  end
end
