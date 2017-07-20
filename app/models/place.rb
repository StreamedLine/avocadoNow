class Place < ActiveRecord::Base
	belongs_to :user
	has_many :thumbs

	def self.getRecent
		self.all.order(:created_at).limit(5)
	end
end