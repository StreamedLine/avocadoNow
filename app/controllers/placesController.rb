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
		place = Place.create(params[:id], params[:place])

		flash[:message] = "Update successful."
		erb :"places/#{place.id}"
	end

	delete '/places:id' do 
		protect_data
		Place.find(params[:id]).destroy
	end
end