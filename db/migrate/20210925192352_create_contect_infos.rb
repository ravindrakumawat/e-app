class CreateContectInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :contect_infos do |t|
      t.integer :business_id
      t.string :contect_type
      t.string :contect
      t.timestamps
    end
  end
end
