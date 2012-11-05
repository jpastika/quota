class AddParentKeyToCatalogItem < ActiveRecord::Migration
  def change
    add_column :catalog_items, :parent_key, :string
    
    add_index :catalog_items, :parent_key
    
  end
end
