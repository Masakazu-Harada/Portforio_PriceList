class User < ApplicationRecord
  #社員モデル 一人の社員が部署を兼任しているので多 対 多で関連付けをする。affiliationモデルで関連づけ
  has_secure_password
  has_many :affiliations, dependent: :destroy
  has_many :departments, through: :affiliations
  has_many :product_histories
  belongs_to :customer, optional: true

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,:presence => true, :format => { :with => VALID_EMAIL_REGEX }

  def employee?
    self.user_type == 'employee'
  end

  def customer?
    self.user_type == 'customer'
  end

  scope :employees, -> { where(user_type: "employee") }
  scope :customers, -> { where(user_type: "customer") }

  def self.ransackable_associations(auth_object = nil)
    ["departments", "customer"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
