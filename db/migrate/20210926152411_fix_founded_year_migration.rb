class FixFoundedYearMigration < ActiveRecord::Migration[6.0]
  def change
    remove_column :businesses, :founded_year
    add_column :businesses, :founded_year, :integer
  end
end
