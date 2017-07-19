class Thumb < ActiveRecord::Base
	belongs_to :place
	belongs_to :user, through: :place
end