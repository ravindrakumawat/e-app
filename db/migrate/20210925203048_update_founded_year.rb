class UpdateFoundedYear < ActiveRecord::Migration[6.0]
  def change
    change_column :businesses, :founded_year, :integer
  end
end
