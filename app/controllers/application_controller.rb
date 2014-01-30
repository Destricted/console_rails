class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_filter :create_session_var

	def create_session_var
		require 'securerandom'
		if session[:user_id].nil?
			session[:user_id] = SecureRandom.hex
		end
	end

	def broadcast(channel, &block)
	    message = {:channel => channel, :data => capture(&block)}
	    uri = URI.parse("http://localhost:9292/faye")
	    Net::HTTP.post_form(uri, :message => message.to_json)
  	end
end
