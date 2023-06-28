class Product < ApplicationRecord
  #商品のモデル 中間モデルprocut_supplierを通して仕入れ先supplierモデルを取得する
  has_many :product_suppliers, dependent: :destroy
  has_many :suppliers, through: :product_suppliers
  has_many :prices, dependent: :destroy
  has_many :cost_increase_histories, through: :product_suppliers, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :code
    validates :catalog_page_number
    validates :spec
  end

  #available カタログ掲載中  
  #to_be_discontinued 売り切り廃盤予定
  #discontinued 廃盤予定
  enum status: { available: 0, to_be_discontinued: 1, discontinued: 2 }
  validates :status, presence: true

  #sheet＝枚   piece＝本 volume＝巻 set=セット pack=パック box=箱
  enum unit: { sheet: 0, piece: 1, volume: 2, set: 3, pack: 4, box: 5, one: 6 }
  validates :unit, presence: true

  #都道府県のenum作成
  enum location: {
    hokkaido: 0, aomori: 1, iwate: 2, miyagi: 3, akita: 4, yamagata: 5, fukushima: 6,
    ibaraki: 7, tochigi: 8, gunma: 9, saitama: 10, chiba: 11, tokyo: 12,kanagawa: 13,
    niigata: 14, toyama: 15, ishikawa: 16, fukui: 17, yamanashi: 18, nagano: 19,
    gifu: 20, shizuoka: 21, aichi: 22, mie: 23, shiga: 24, kyoto: 25, osaka: 26,
    hyogo: 27, nara: 28, wakayama: 29, tottori: 30, shimane: 31, okayama: 32,
    hiroshima: 33, yamaguchi: 34, tokushima: 35, kagawa: 36, ehime: 37, kochi: 38,
    fukuoka: 39, saga: 40, nagasaki: 41, oita: 42, kumamoto: 43, miyazaki: 44,
    kagoshima: 45, okinawa: 46, unknown: 47
  }

  def self.ransackable_attributes(auth_object = nil)
    ["code", "name", "catalog_page_number"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["price_increase_histories", "prices", "product_suppliers", "suppliers"]
  end

  def name_with_status
    case self.status
    when "to_be_discontinued"
      "#{self.name} (売り切り廃盤予定)"
    when 'discontinued'
      "#{self.name} (廃盤予定)"
    else
      self.name
    end
  end

  #粗利を計算するメソッド
  def gross_margins(price)
    product_suppliers.map do |supplier|
      if price.current_price && supplier.current_cost
        { 
          supplier: supplier,
          margin: price.current_price - supplier.current_cost 
        }
      else
        {
          supplier: supplier,
          margin: 'N/A'
        }
      end
    end
  end
  
  #粗利益を計算するメソッド
  def gross_profit_percentages(price)
    product_suppliers.map do |supplier|
      if price.current_price && supplier.current_cost
        { 
          supplier: supplier,
          percentage: (supplier.current_cost.to_f / price.current_price.to_f * 100).round(2)
        }
      else
        {
          supplier: supplier,
          percentage: nil # ここを 'N/A' から nil に変更
        }
      end
    end
  end

  #粗利益が10（%）以下かどうかを判定するメソッド
  def low_margins?(price)
    gross_profit_percentages(price).map do |gross_profit_percentage|
      {
        supplier: gross_profit_percentage[:supplier],
        is_low: gross_profit_percentage[:percentage] && gross_profit_percentage[:percentage] <= 10 # ここを修正: percentageが存在する場合のみ比較を行う
      }
    end
  end

  before_validation :setup_prices

  def setup_prices
    Rank.all.each do |rank|
      self.prices.find_or_initialize_by(rank: rank)
    end
  end
end
