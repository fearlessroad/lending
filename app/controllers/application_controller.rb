class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def require_login
  	redirect_to :root if session[:type] = nil
  end

  def require_correct_borrower
  		user = Borrower.find(params[:id])
  		redirect_to "/online_lending/#{session[:role_id]}/#{current_user.id}" if current_user != user
  end
  def require_correct_lender
  		user = Lender.find(params[:id])
  		redirect_to "/online_lending/#{session[:role_id]}/#{current_user.id}" if current_user != user
	end 
	def current_user
		if session[:role_id] == "borrower"
			Borrower.find(session[:borrower_id]) if session[:borrower_id]
   		elsif session[:role_id] == "lender"
   			Lender.find(session[:lender_id]) if session[:lender_id]
   		end
 	end
  helper_method :current_user
end
