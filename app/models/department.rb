class Department < ApplicationRecord
  #部署モデル 営業部・購買部・管理部・業務部の４部署をnameカラムを持つ 中間モデルのaffiliationモデルを通してuserモデルのレコードを取得する 多 対 多
  has_many :affiliations, dependent: :destroy
  has_many :users, through: :affiliations
  validates :name, presence: true

  enum position: {
    東日本営業課: 1,
    西日本営業課: 2,
    購買課: 3,
    業務課: 4,
    管理課: 5,
    物流課: 6,
    営業推進課: 7,
  }
end
