class AddMoreColumnToBusiness < ActiveRecord::Migration[6.0]
  def change
    add_column :businesses, :domain, :string
    add_column :businesses, :logo, :string
    add_column :businesses, :company_name, :string
    add_column :businesses, :external_id, :string
  end
end
