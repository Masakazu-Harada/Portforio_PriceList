class Affiliation < ApplicationRecord
  #社員と部署を繋ぐ中間モデル
  belongs_to :user
  belongs_to :department
end
