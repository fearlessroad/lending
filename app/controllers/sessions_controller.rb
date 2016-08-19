class SessionsController < ApplicationController
	
	def create
		# first check to see if the email address is present in the borrower's database 
		user = Borrower.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:role_id] = "borrower"
			session[:borrower_id] = user.id
			redirect_to "/online_lending/borrower/#{user.id}"
		else
		# if user was not found OR if they entered the wrong password.... 
			user = Lender.find_by(email: params[:email])
			if user && user.authenticate(params[:password])
				# session = {"lender_id"=>user.id, "type"=>"lender"}
				session[:role_id] = "lender"
				session[:lender_id] = user.id
				redirect_to "/online_lending/lender/#{user.id}"
			else 
		# # this else statement will run if user is not found in any database or if they are found but they entered the wrong password
				flash[:errors] = ["Sorry, we couldn't find a user with that email/password combination!"]
				redirect_to :back
			end
		end
	end

	def destroy
		reset_session
		redirect_to :root
	end
end
