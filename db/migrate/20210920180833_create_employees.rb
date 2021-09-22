class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.integer :business_id
      t.string :email
      t.string :designation
      t.date   :joining_date

      t.timestamps
    end
  end
end
