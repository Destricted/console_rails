class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_filter :create_session_var

	def create_session_var
		require 'securerandom'
		if session[:user_id].nil?
			session[:user_id] = SecureRandom.hex
		end
	end
end
