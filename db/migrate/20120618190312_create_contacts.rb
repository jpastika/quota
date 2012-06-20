class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :pub_key
      t.string :account_key
      t.string :title
      t.string :company_key
      t.string :contact_type
      t.boolean :is_disabled

      t.timestamps
    end
    
    add_index :contacts, :pub_key
    add_index :contacts, :company_key
    add_index :contacts, :account_key
    add_index :contacts, :contact_type
  end
end
