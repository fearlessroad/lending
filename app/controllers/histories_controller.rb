class HistoriesController < ApplicationController
	before_action :require_login
	def create
		# create the history 
		lender = Lender.find(session[:lender_id])
		borrower = Borrower.find(params[:id])
		if params[:amount].to_i > lender.money
			flash[:errors] = ["You have insufficient funds!"]
			redirect_to :back
		else
			loan = History.where(lender:lender, borrower: borrower).first
			if loan 
				# first update amount in history
				loanraised = loan.amount += params[:amount].to_i
				loan.update(amount: loanraised)
				# then update amount in borrower
				raised = borrower.raised
				raised += params[:amount].to_i
				borrower.update(raised: raised)
				# then update balance on lender account
				account = lender.money
				account -= params[:amount].to_i
				lender.update(money: account)
				# finally, redirect
				redirect_to :back
			else
				loan = History.create(lender: lender, borrower: borrower, amount: params[:amount])
				if loan.save 
					# update the amount raised for the borrower
					raised = borrower.raised
					raised += params[:amount].to_i
					borrower.update(raised: raised)
					# update the account balance on the lender
					account = lender.money
					account -= params[:amount].to_i
					lender.update(money: account)
				else 
					flash[:errors] = loan.errors.full_messages
				end
				redirect_to :back
			end
		end
	end
end

# additional feature
# If the borrower's name is already on the "List of People Lent Money To", the name does not need to be appended to the table. But the original amount of Money Raised and Money Lent should update/increment with the new amount lent