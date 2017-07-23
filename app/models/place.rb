class Place < ActiveRecord::Base
	belongs_to :user
	has_many :thumbs

	def self.getRecent(lmt = -1)
		self.order('updated_at DESC').order('expired ASC')[0..lmt]
	end
end