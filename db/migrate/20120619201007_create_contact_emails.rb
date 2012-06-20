class CreateContactEmails < ActiveRecord::Migration
  def change
    create_table :contact_emails do |t|
      t.string :name
      t.string :val
      t.string :pub_key
      t.string :contact_key
      t.string :account_key
      t.boolean :is_disabled, :default => false

      t.timestamps
    end
    
    add_index :contact_emails, :pub_key
    add_index :contact_emails, :contact_key
    add_index :contact_emails, :account_key
  end
end
