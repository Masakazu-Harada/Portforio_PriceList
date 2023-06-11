class ProductSupplier < ApplicationRecord
  attr_accessor :future_cost

  belongs_to :product
  belongs_to :supplier
  has_many :cost_increase_histories, dependent: :destroy

  def handle_cost_increase_history_on_create(cost_increase_history_params, user)
    cost_increase_history = cost_increase_histories.new(cost_increase_history_params.except(:future_cost))
    cost_increase_history.user = user
    cost_increase_history.cost_revision_date ||= Date.today
    if save && cost_increase_history.save
      create_cost_history(cost_increase_history.current_cost)
    end
  end

  def handle_cost_increase_history_on_update(cost_increase_history_params, user)
    cost_increase_history = cost_increase_histories.find_or_initialize_by(id: cost_increase_history_params[:id])
    cost_increase_history.assign_attributes(cost_increase_history_params.except(:future_cost))
    cost_increase_history.user = user
    self.future_cost = cost_increase_history_params[:future_cost]
    cost_increase_history.current_cost = self.future_cost
    cost_increase_history.cost_revision_date ||= Date.today
    if save && cost_increase_history.save
      create_cost_history(future_cost)
    end
  end

  def schedule_cost_update_job(date)
    Sidekiq::PerformIn.new(date.to_time, 'ProductSupplierCostUpdateWorker', id)
  end

  #def update_cost
    #latest_cost_increase_history = cost_increase_histories.order(cost_revision_date: :desc).first
    #if latest_cost_increase_history&.cost_revision_date && latest_cost_increase_history.cost_revision_date <= Date.today
      #update(current_cost: latest_cost_increase_history.current_cost)
    #end
  #end

  def update_cost
    latest_cost_increase_history = cost_increase_histories.where("cost_revision_date <= ?", Date.today).order(updated_at: :desc).first
    if latest_cost_increase_history&.cost_revision_date
      update(current_cost: latest_cost_increase_history.current_cost)
    end
  end

  after_create :create_initial_cost_history
  after_update :create_updated_cost_history, if: :future_cost_present?

  after_save :notify_future_cost, if: :future_cost_changed?

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
    #next_scheduled_cost_revision_date || "-"
    next_scheduled_history = future_cost_increase_history
    next_scheduled_history&.cost_revision_date
  end

  private

  def create_initial_cost_history
    create_cost_history(future_cost)
  end

  def create_updated_cost_history
    create_cost_history(future_cost)
  end

  def create_cost_history(cost)
    cost_increase_histories.create(current_cost: cost)
  end

  def future_cost_present?
    future_cost.present?
  end

  def future_cost_changed?
    saved_change_to_attribute?(:future_cost)
  end

  def notify_future_cost
    # 未来のコスト通知ロジックをここで実装予定
  end

  def next_scheduled_cost
    next_scheduled_history = future_cost_increase_history
    next_scheduled_history&.current_cost
  end

  def next_scheduled_cost_revision_date
    next_scheduled_history = future_cost_increase_history
    next_scheduled_history&.cost_revision_date
  end

  #def future_cost_increase_history
    #cost_increase_histories
      #.where("cost_revision_date > ?", Date.today)
      #.order(cost_revision_date: :asc)
      #.first
  #end
  def future_cost_increase_history
    cost_increase_histories
      .where("cost_revision_date > ?", Date.today)
      .order(updated_at: :desc)
      .first
  end

  def self.ransackable_attributes(auth_object = nil)
    super + ['product_name']
  end

  def self.ransackable_associations(auth_object = nil)
    super + ['product']
  end
end
