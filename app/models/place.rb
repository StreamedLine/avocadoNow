class Place < ActiveRecord::Base
	belongs_to :user
	has_many :thumbs

	def self.getRecent(lmt = -1)
		self.order('expired ASC').order('updated_at DESC')[0..lmt]
	end
end