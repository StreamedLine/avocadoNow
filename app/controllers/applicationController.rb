class ApplicationController < Sinatra::Base
	register Sinatra::Flash
	configure do 	
		set :public_folder, 'public'
		enable :sessions
		set :views, 'app/views'
		set :session_secret, "password_security"
	end

	helpers do
		def protect_data(message = nil)
			if !logged_in?
				flash[:message] = message
				redirect '/users/login' 
			end
		end

		def is_owner?(user)
			user == current_user
		end

		def logged_in?
			!!current_user
		end

		def current_user
			@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
		end
	end
end