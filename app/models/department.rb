class Department < ApplicationRecord
  #部署モデル 営業部・購買部・管理部・業務部の４部署をnameカラムを持つ 中間モデルのaffiliationモデルを通してuserモデルのレコードを取得する 多 対 多
  has_many :affiliations
  has_many :users, through: :affiliations
end
