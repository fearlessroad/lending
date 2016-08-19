class LendersController < ApplicationController
	def create
		lender = Lender.new(lender_params)
		if lender.save
			session[:lender_id]= lender.id
			session[:role_id] = "lender"
			redirect_to "/online_lending/lender/#{lender.id}"
		else
			flash[:errors] = lender.errors.full_messages
			redirect_to :back
		end
	end
private
	def lender_params
		params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
	end
end
