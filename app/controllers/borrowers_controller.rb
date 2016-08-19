class BorrowersController < ApplicationController
	def create
		borrower = Borrower.new(borrower_params)
		if borrower.save
			session[:borrower_id]= borrower.id
			session[:role_id] = "borrower"
			borrower.update(raised:"0")
			redirect_to "/online_lending/borrower/#{borrower.id}"
		else
			flash[:errors] = borrower.errors.full_messages
			redirect_to :back
		end
	end
private
	def borrower_params
		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :purpose, :description, :money)
	end
end
