class CreateContactPhones < ActiveRecord::Migration
  def change
    create_table :contact_phones do |t|
      t.string :name
      t.string :val
      t.string :pub_key
      t.string :contact_key
      t.string :contact_type
      t.boolean :is_disabled, :default => false
      
      t.timestamps
    end
    
    add_index :contact_phones, :pub_key
    add_index :contact_phones, :contact_key
    
  end
end
