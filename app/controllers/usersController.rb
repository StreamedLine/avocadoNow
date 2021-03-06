class UsersController < ApplicationController
	##########
	#  SIGNUP
	get '/users/signup' do 
		@logged_out = true unless logged_in?
		erb :'users/signup'
	end

	post '/users/signup' do 
		if params[:name] == "" || params[:password] == ""
  			flash[:error] = "Username and password required"
	        redirect '/users/signup' #early return
	    else

	    	if User.find_by(name: params[:name])
	    		flash[:error] = 'Sorry, name already in use. Please choose a different username'
	        	redirect '/users/signup' #early return
	    	end

	        if User.create(name: params[:name], password: params[:password]) 
	        	session[:user_id] = @user.id
	   	   		flash[:message] = "successfully logged in"
	   	   		redirect to "/"
	   	   	end
	    end
		erb :'users/login'
	end

	##########
	#  LOGIN
	get '/users/login' do 
		@logged_out = true unless logged_in?
		erb :'users/login'
	end

	post '/users/login' do 
		@user = User.find_by(name: params[:name])

    	if @user && @user.authenticate(params[:password])
	   	   session[:user_id] = @user.id
	   	   flash[:message] = "successfully logged in"
	   	   redirect to "/"
	   	 else
	   	   flash[:error] = "Login failed"
	   	   redirect to "/users/login"
	   	 end
	end

	##########
	#  LOGOUT
	get '/users/logout' do
		session.clear
		flash[:message] = "successfully logged out"
		redirect '/users/login'
	end

	##########
	#  PROFILE
	get '/' do
		redirect '/places' unless logged_in?  

		@user = current_user
		@thumb_count = @user.thumbs.count 
		erb :index
	end
end