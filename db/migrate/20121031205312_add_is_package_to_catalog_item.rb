class AddIsPackageToCatalogItem < ActiveRecord::Migration
  def change
    add_column :catalog_items, :is_package, :boolean, :default => false
  end
end
