class Department < ApplicationRecord
  #部署モデル 営業部・購買部・管理部・業務部の４部署
  has_many :affiliations
  has_many :users, througth: :affiliations
end
