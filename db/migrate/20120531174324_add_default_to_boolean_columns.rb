class AddDefaultToBooleanColumns < ActiveRecord::Migration
  def change
    add_column :accounts, :is_disabled, :boolean, :default => false
    add_column :users, :is_disabled, :boolean, :default => false
    
    change_column :catalog_items, :is_recurring, :boolean, :default => false
    change_column :catalog_items, :is_subscription, :boolean, :default => false
    change_column :catalog_items, :is_taxable, :boolean, :default => false
    change_column :documents, :is_draft, :boolean, :default => true
  end
end
