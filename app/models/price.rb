class Price < ApplicationRecord
  #priceカラムを持つ中間モデル 多(productモデル) 対 多(rankモデル)
  belongs_to :product
  belongs_to :rank
  has_many :price_change_histories, dependent: :destroy
  validates_uniqueness_of :rank_id, scope: :product_id

  attr_accessor :update_price
  attr_accessor :published_at

  after_save :create_price_change_history, if: :price_changed?
  # TODO: メーラー機能を実装する時に追記する予定
  # after_save do
  #   if self.published_at && self.published_at >= Date.today
  #     customer_notification
  #   end
  # end

  def current_price
    last_price_change = self.price_change_histories.order(id: :desc).where.not("change_price_date > ?", Date.today).first
    last_price_change ? last_price_change.new_price : self.price
  end

  after_save do
    if self.published_at && self.published_at >= Date.today
      customer_notification
    end
  end

  private

  def create_price_change_history
    self.price_change_histories.create(
      old_price: self.price_was,
      new_price: self.price,
      change_price_date: self.published_at || Time.current
    )
  end

  #def notify_customers
    # ここにお客さんへの通知処理を書く
  #end
end
