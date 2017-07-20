class AddExpiredColumnToPlaces < ActiveRecord::Migration[5.1]
  def change
  	add_column :places, :expired, :boolean
  end
end
