class AddUserIdToThumbs < ActiveRecord::Migration[5.1]
  def change
  	add_column :thumbs, :user_id, :integer
  end
end
