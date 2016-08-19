class Lender < ActiveRecord::Base
  has_secure_password
  has_many :borrowers, through: :histories
  has_many :histories

  validates :first_name, :last_name, :email, :money, presence:true
end
