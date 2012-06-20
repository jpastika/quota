class CreateContactAddresses < ActiveRecord::Migration
  def change
    create_table :contact_addresses do |t|
      t.string :name
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :county
      t.string :pub_key
      t.string :contact_key
      t.string :account_key
      t.boolean :is_disabled, :default => false

      t.timestamps
    end
    
    add_index :contact_addresses, :pub_key
    add_index :contact_addresses, :contact_key
    add_index :contact_addresses, :account_key
  end
end
