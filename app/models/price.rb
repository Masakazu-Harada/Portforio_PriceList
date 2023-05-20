class Price < ApplicationRecord
  belongs_to :product
  belongs_to :rank
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by_user_id', optional: true
  belongs_to :updater, class_name: 'User', foreign_key: 'updated_by_user_id', optional: true

  has_many :price_change_histories

  validates_uniqueness_of :rank_id, scope: :product_id


  before_save :update_price_and_reset_future_price, if: :price_increase_date_reached?
  after_save :create_price_change_history, if: :saved_change_to_price?

  def creator_name
    creator&.name || "新規登録者なし"
  end

  def updater_name
    updater&.name || '更新者なし'
  end

  def current_price
    self.price
  end

  private

  #①価格上昇予定日が設定されていない場合（price_increase_dateが nil）はfalseを返し価格は更新されない。
  #②価格上昇予定日が設定されているが、その日付が未来の場合: このメソッドは false を返し、価格は更新されない。
  #③価格上昇予定日が設定されていて、その日付が今日または過去の場合: このメソッドは true を返し、before_save コールバックがupdate_price_and_reset_future_priceメソッドを呼び出す。この結果、価格が更新される。
  def price_increase_date_reached?
    self.price_increase_date && self.price_increase_date <= Date.today
  end

  #self.future_price（将来の価格）が存在すれば、つまりnilでなければ、self.price（現在の価格）にself.future_priceを代入する。つまり、現在の価格を将来の価格で更新される。
  #self.future_priceをnilにリセットする。これにより、将来の価格は未設定状態になる。 self.price_increase_date（価格上昇予定日）もnilにリセットする。
  #つまり、このメソッドは「価格上昇予定日が到来したら、将来の価格で現在の価格を更新し、それらの将来の設定をリセットする」という動作を行いbefore_saveコールバックによって呼び出される。

  #before_save :update_price_and_reset_future_price, if: :price_increase_date_reached?

  def update_price_and_reset_future_price
    if self.future_price
      self.price = self.future_price
      self.future_price = nil
      self.price_increase_date = nil
    end
  end

  def create_price_change_history
    if saved_change_to_price?
      self.price_change_histories.create(
        old_price: self.price_before_last_save,
        new_price: self.price,
        change_price_date: self.price_increase_date ? self.price_increase_date : nil,
        user_id: self.updated_by_user_id
      )
    end
  end
end
