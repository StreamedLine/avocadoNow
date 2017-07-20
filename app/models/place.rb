class Place < ActiveRecord::Base
	belongs_to :user
	has_many :thumbs

	def self.getRecent(lmt = -1)
		self.all.order(:updated_at)[0..lmt]
	end
end