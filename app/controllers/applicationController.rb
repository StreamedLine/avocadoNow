class ApplicationController < Sinatra::Base
	register Sinatra::Flash
	configure do 	
		set :public_folder, 'public'
		enable :sessions
		set :views, 'app/views'
		set :session_secret, "password_security"
	end

	helpers do
		def protect_data
			redirect '/users/login' unless logged_in?
		end

		def is_current_user?(user_id)
			user_id == current_user.id
		end

		def logged_in?
			!!current_user
		end

		def current_user
			@current_user ||= [nil, ""].include?(session[:user_id]) ? nil : User.find(session[:user_id])
		end
	end
end