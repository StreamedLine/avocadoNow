class ThumbsController < ApplicationController
	get '/places/:id/thumbs/new' do 
		protect_data
		Place.update(params[:id], {expired: false})
		Place.thumbs.create(user_id: current_user)

		redirect '/places'
	end

end