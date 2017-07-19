class UsersController < ApplicationController
	##########
	#  SIGNUP
	get '/users/signup' do 
		erb :'users/create'
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

	        User.create(name: params[:name], password: params[:password]) 
	    end
		erb :index
	end

	##########
	#  LOGIN
	get '/users/login' do 
		erb :'users/login'
	end

	post '/users/login' do 
		@user = User.find_by(name: params[:name])

    	if @user && @user.authenticate(params[:password])
	   	   session[:user_id] = @user.id
	   	   flash[:message] = "successfully logged in"
	   	   redirect to "/places/index"
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
end