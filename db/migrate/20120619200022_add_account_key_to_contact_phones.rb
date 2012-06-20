class AddAccountKeyToContactPhones < ActiveRecord::Migration
  def change
    add_column :contact_phones, :account_key, :string
    remove_column :contact_phones, :contact_type
    
    add_index :contact_phones, :account_key
    
    change_column :contacts, :is_disabled, :boolean, :default => false
  end
end
