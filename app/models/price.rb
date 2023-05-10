class Price < ApplicationRecord
  #priceカラムを持つ中間モデル 多(productモデル) 対 多(rankモデル)
  belongs_to :product
  belongs_to :rank
  has_many :price_change_histories, dependent: :destroy

  attr_accessor :foobar
  attr_accessor :update_price
  attr_accessor :published_at

  after_save do
    self.histories.create(
      price: update_price.to_i,
      published_at: published_at
    )
  end

  def current_price
    # self.histories.last[:price]

    self.hisotories.order(id: :desc).where.not(published_at: '今日よりもミライの日付').last
  end

  after_save do
    if self.published_at >= Date.today
      customer_notification
    end
  end

  private

  def customer_notification
    # お客さんにいついつ価格の値上げを予定しています
  end
end
