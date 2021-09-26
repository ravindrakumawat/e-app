class AddLatAndLngToBusiness < ActiveRecord::Migration[6.0]
  def change
    add_column :businesses, :latitude, :string
    add_column :businesses, :longitude, :string
  end
end
