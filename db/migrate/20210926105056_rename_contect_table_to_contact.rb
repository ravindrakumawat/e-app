class RenameContectTableToContact < ActiveRecord::Migration[6.0]
  def change
    rename_column :contect_infos, :contect_type, :contact_type
    rename_column :contect_infos, :contect, :contact
    rename_table :contect_infos, :contact_infos
  end
end
