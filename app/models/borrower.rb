class Borrower < ActiveRecord::Base
  has_secure_password
  has_many :lenders, through: :histories
  has_many :histories

  validates :first_name, :last_name, :email, :money, :purpose, :description, presence:true
end
