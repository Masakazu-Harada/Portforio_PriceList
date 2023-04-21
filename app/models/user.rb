class User < ApplicationRecord
  #社員モデル 一人の社員が部署を兼任しているので多 対 多で関連付けをする。affiliationモデルで関連づけ
  has_secure_password
  has_many :affiliations, dependent: :destroy
  has_many :departments, through: :affiliations
  has_one :customer

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def employee?
    self.user_type == 'employee'
  end

  def customer?
    self.user_type == 'customer'
  end

  scope :employees, -> { where(user_type: "employee") }
  scope :customers, -> { where(user_type: "customer") }
end
