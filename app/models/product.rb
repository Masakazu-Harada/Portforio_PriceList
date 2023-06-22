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

  before_validation :setup_prices

  def setup_prices
    Rank.all.each do |rank|
      self.prices.find_or_initialize_by(rank: rank)
    end
  end
end
