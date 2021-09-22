class CreateBusinesses < ActiveRecord::Migration[6.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.text :about
      t.string :address
      t.string :city
      t.string :state
      t.string :post_code
      t.string :country
      t.string :contact_email
      t.string :phone_number
      t.string :owner_name
      t.date   :founded_date
      t.integer :no_of_employees
      t.timestamps
    end
  end
end
