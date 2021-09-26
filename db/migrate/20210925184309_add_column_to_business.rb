class AddColumnToBusiness < ActiveRecord::Migration[6.0]
  def change
    add_column :businesses, :time_zone, :string
    rename_column :businesses, :founded_date, :founded_year
  end
end
