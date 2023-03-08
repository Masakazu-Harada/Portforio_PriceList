class Customer < ApplicationRecord
  #顧客モデル rankモデルに所属する子モデル 一(customerモデル) 対 多(rankモデル)
  belongs_to :rank
  validates :name, :share, presence: true
end
