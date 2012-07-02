class AddContactTypeKeyToContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :contact_type
    
    add_column :contacts, :contact_type_key, :string
  end
end
