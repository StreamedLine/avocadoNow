class Place < ActiveRecord::Base
	belongs_to :user
	has_many :thumbs

	def self.getRecent(lmt = -1)
		self.where(expired: nil).or(self.where(expired: false)).order('updated_at DESC')[0..lmt]
	end

	def self.getExpired(lmt = -1)
		self.where(expired: true)[0..lmt]
	end
end