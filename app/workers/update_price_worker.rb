class UpdatePriceWorker
  include Sidekiq::Worker

  def perform(*args)
    # 値上げ予定日が今日または過去のものを取得
    prices = Price.where('price_increase_date <= ?', Date.today)

    # 各価格を更新する
    prices.each do |price|
      # 現在の価格を更新
      price.update(price: price.future_price)
    end
  end
end
