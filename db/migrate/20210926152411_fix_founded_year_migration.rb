class FixFoundedYearMigration < ActiveRecord::Migration[6.0]
  def change
    change_column :businesses, :founded_year, :string
  end
end
