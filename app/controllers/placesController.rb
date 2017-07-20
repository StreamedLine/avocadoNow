class PlacesController < ApplicationController
	get '/places' do 
		protect_data
		@places = Place.getRecent
		erb :'/places/index'
	end

	get '/places/new' do 
		protect_data
		erb :'places/new'
	end

	post '/places' do 
		protect_data
		place = Place.create(params[:place])

		flash[:message] = "Avocado now! Success!"
		redirect "places/#{place.id}"
	end

	get '/places/:id' do 
		protect_data

		@place = Place.find(params[:id])
		@editable = is_current_user?(@place.user_id) ? true : nil 
		erb :'places/show'
	end

	get '/places/:id/edit' do
		protect_data

		@place = Place.find(params[:id])
		erb :'places/edit'
	end 

	patch '/places/:id' do 
		protect_data

		if is_current_user?(Place.find(params[:id]).user_id)
			place = Place.update(params[:id], params[:place])
			flash[:message] = "Update successful."
			redirect "places/#{place.id}"
		else
			flash[:error] = "You can only update your own post."
			redirect "places/#{place.id}"
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

	get '/places/:id/expired' do 
		protect_data

		Place.update(params[:id], {expired: true})
		redirect '/places'
	end

	
end