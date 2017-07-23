class AddTimestampsToThumbs < ActiveRecord::Migration[5.1]
  	def change
  		add_column(:thumbs, :created_at, :datetime)
    	add_column(:thumbs, :updated_at, :datetime)
  	end
end
