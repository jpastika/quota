class CreateDocumentItems < ActiveRecord::Migration
  def change
    create_table :document_items do |t|
      t.string :name
      t.string :part_number
      t.float :quantity
      t.float :unit_price
      t.string :discount
      t.boolean :is_taxable, :default => true
      t.boolean :is_discountable, :default => true
      t.float :total
      t.text :notes
      t.integer :sort_order
      t.boolean :is_hidden, :default => false
      t.string :document_item_type
      t.float :day_rate
      t.float :week_rate
      t.float :month_rate
      t.float :buyout
      t.string :serial_number
      t.text :description
      t.string :pub_key
      t.string :document_key
      t.string :account_key
      t.string :catalog_item_key
      t.boolean :is_disabled, :default => false
      t.string :parent_item_key

      t.timestamps
    end
    
    add_index :document_items, :pub_key
    add_index :document_items, :document_key
    add_index :document_items, :catalog_item_key
    add_index :document_items, :account_key
  end
end
