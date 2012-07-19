class CreateOpportunityContacts < ActiveRecord::Migration
  def change
    create_table :opportunity_contacts do |t|
      t.string :opportunity_key
      t.string :contact_key
      t.string :is_disabled, :default => false
      t.string :boolean
      t.string :pub_key
      t.string :account_key

      t.timestamps
    end
    
    add_index :opportunity_contacts, :opportunity_key
    add_index :opportunity_contacts, :contact_key
    add_index :opportunity_contacts, :account_key
  end
end
