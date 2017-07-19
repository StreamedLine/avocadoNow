class CreateThumbsUp < ActiveRecord::Migration[5.1]
  def change
  	create_table :thumbs do |t|
  		t.integer :place_id
  	end
  end
end
