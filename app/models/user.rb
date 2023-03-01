class User < ApplicationRecord
  #社員モデル 一人の社員が部署を兼任しているので多 対 多で関連付けをする。affiliationモデルで関連づけ
  has_secure_password
  has_many :affiliations
  has_many :departments, through: :affiliations
end
