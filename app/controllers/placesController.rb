class PlacesController < ApplicationController
	get '/places/new' do 
		protect_data
		erb :'places/new'
	end

	post '/places' do 
		protect_data
		place = Place.create(params[:place])

		flash[:message] = "Avocado now! Success!"
		erb :"places/#{place.id}"
	end

	get '/places/:id' do 
		protect_data
		@place = Place.find(params[:id])
		erb :'places/show'
	end

	patch '/places/:id' do 
		protect_data

		if is_current_user?(Place.find(params[:id]).user_id)
			place = Place.update(params[:id], params[:place])
			flash[:message] = "Update successful."
			erb :"places/#{place.id}"
		else
			flash[:error] = "You can only update your own post."
			erb :"places/#{place.id}"
		end
	end

	delete '/places:id' do 
		protect_data

		if is_current_user?(Place.find(params[:id]).user_id)
			place = Place.find(params[:id]).destroy
			flash[:message] = "Delete successful."
			redirect '/'
		else
			flash[:error] = "You can only delete your own post."
			redirect "/places/#{params[:id]}"
		end
	end
end