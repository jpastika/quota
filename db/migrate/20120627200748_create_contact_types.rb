class CreateContactTypes < ActiveRecord::Migration
  def change
    create_table :contact_types do |t|
      t.string :name
      t.boolean :is_disabled, :default => false
      t.string :account_key
      t.string :pub_key
      t.string :icon_class
      t.boolean :is_default, :default => false

      t.timestamps
    end
    
    add_index :contact_types, :pub_key
    add_index :contact_types, :name
    add_index :contact_types, :account_key
    
    remove_column :document_item_types, :is_disabled
    
    add_column :document_item_types, :is_disabled, :boolean, :default => false
  end
end
