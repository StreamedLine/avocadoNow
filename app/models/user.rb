class User < ActiveRecord::Base
	has_many :places
	has_many :thumbs
	
	has_secure_password
end