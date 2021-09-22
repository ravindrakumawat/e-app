class AddOwnerIdToBusiness < ActiveRecord::Migration[6.0]
  def change
    add_column :businesses, :owner_id, :integer
  end
end
