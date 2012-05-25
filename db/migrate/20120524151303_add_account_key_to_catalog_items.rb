class AddAccountKeyToCatalogItems < ActiveRecord::Migration
  def change
    remove_index :catalog_items, :account_id
    remove_column :catalog_items, :account_id
    
    add_column :catalog_items, :account_key, :string
    add_index :catalog_items, :account_key
  end
end
