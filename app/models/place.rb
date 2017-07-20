class Place < ActiveRecord::Base
	belongs_to :user
	has_many :thumbs

	def self.getRecent(lmt = -1)
		self.order('updated_at desc')[0..-1]
	end
end