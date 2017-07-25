class ThumbsController < ApplicationController
	get '/places/:id/thumbs/new' do 
		protect_data
		recent_thumb = current_user.thumbs.order('updated_at desc').select{|t| t.place_id == params[:id].to_i}.first 
		if recent_thumb && recent_thumb.place_id == params[:id].to_i && Time.now - recent_thumb.updated_at < 10800
			flash[:error] = "You've already confirmed that location. Thank you."
		else
			place = Place.update(params[:id], {expired: false})
			place.touch
			place.thumbs.create(user_id: current_user.id)
			flash[:message] = "The community thanks you!"
		end
		redirect '/places'
	end

end