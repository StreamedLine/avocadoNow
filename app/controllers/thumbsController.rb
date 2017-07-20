class ThumbsController < ApplicationController
	get '/places/:id/thumbs/new' do 
		protect_data
		place = Place.update(params[:id], {expired: false})
		place.thumbs.create(user_id: current_user)

		redirect '/places'
	end

end