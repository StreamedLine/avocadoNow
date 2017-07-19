class User < ActiveRecord::Base
	has_many :places
	has_many :thumbs, through: :places
	
	has_secure_password
end