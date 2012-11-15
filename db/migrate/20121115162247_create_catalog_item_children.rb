class CreateCatalogItemChildren < ActiveRecord::Migration
  def change
    create_table :catalog_item_children do |t|
      t.string :account_key
      t.string :pub_key
      t.string :parent_key
      t.string :child_key

      t.timestamps
    end
    
    add_index :catalog_item_children, :parent_key
    add_index :catalog_item_children, :account_key
    add_index :catalog_item_children, :child_key
  end
end
