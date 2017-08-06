	class PlacesController < ApplicationController
	get '/places' do 
		@places = Place.getRecent
		@expired = Place.getExpired
		erb :'/places/index'
	end

	get '/places/new' do 
		if !logged_in? 
			flash[:error] = "Please log in to submit location"
			redirect '/users/login'
		end
		erb :'places/new'
	end

	post '/places' do 
		protect_data("Please log in to submit location")
		current_user.places.create(params[:place])

		flash[:message] = "Avocado now! Success!"
		redirect "places/#{current_user.places.last.id}"
	end

	get '/places/:id' do 
		@place = Place.find(params[:id])
		@editable = is_owner?(@place.user) ? true : nil 
		erb :'places/show'
	end

	get '/places/:id/edit' do
		protect_data
		@place = Place.find(params[:id])
		if is_owner?(@place.user)
			erb :'places/edit'
		else
			redirect to '/places'
		end
	end 

	patch '/places/:id' do 
		protect_data("You must be logged to update this location")
		place = Place.find(params[:id])
		if is_owner?(place.user)
			place.update(params[:place])
			flash[:message] = "Update successful."
			redirect "places/#{place.id}"
		else
			flash[:error] = "You can only update your own post."
			redirect "places/#{params[:id]}"
		end
	end

	delete '/places:id' do 
		protect_data
		place = Place.find(params[:id])
		if is_owner?(place.user)
			place.destroy
			flash[:message] = "Delete successful."
			redirect '/'
		else
			flash[:error] = "You can only delete your own post."
			redirect "/places/#{params[:id]}"
		end
	end

	get '/places/:id/expired' do 
		Place.update(params[:id], {expired: true})
		redirect '/places'
	end
	
end