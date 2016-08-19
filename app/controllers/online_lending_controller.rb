class OnlineLendingController < ApplicationController
	# user authentication
	before_action :require_login, except: [:register, :login]
	# user authorization
	before_action :require_correct_borrower, only: [:borrower]
	before_action :require_correct_lender, only: [:lender]

	def register
	end
	def login
	end
	def borrower
		@borrower = Borrower.find(session[:borrower_id])
		@history = History.joins(:lender).select("histories.amount, lenders.first_name, lenders.last_name, lenders.email").where(borrower: Borrower.find(session[:borrower_id]))
	end
	def lender 
		@lender = Lender.find(session[:lender_id])
		@needhelp = Borrower.all
		@lendhistory = History.joins(:borrower).select("histories.amount, borrowers.first_name, borrowers.last_name, borrowers.purpose, borrowers.description, borrowers.raised, borrowers.money").where(lender: @lender)
	end
end
