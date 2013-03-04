class AddQuantityToCatalogItemChild < ActiveRecord::Migration
  def change
    add_column :catalog_item_children, :quantity, :float, :default => 1
  end
end
