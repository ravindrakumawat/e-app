class CreateSocialAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :social_accounts do |t|
      t.integer :business_id
      t.string  :social_network
      t.string  :handle
      t.text    :account_details
      t.timestamps
    end
  end
end
