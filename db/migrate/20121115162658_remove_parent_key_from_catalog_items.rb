class RemoveParentKeyFromCatalogItems < ActiveRecord::Migration
  def change
    remove_index :catalog_items, :parent_key
    remove_column :catalog_items, :parent_key
  end
end
