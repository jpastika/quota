class CreateTemplateItems < ActiveRecord::Migration
  def change
    create_table :template_items do |t|
      t.float :buyout
      t.string :catalog_item_key
      t.float :day_rate
      t.text :description
      t.float :discount
      t.string :document_item_type_key
      t.string :template_key
      t.boolean :is_disabled, :default => false
      t.boolean :is_discountable, :default => true
      t.boolean :is_hidden, :default => false
      t.boolean :is_taxable, :default => true
      t.float :month_rate
      t.string :name
      t.text :notes
      t.string :parent_item_key
      t.string :part_number
      t.float :quantity
      t.integer :sort_order
      t.float :total
      t.float :unit_price
      t.float :week_rate
      t.string :pub_key
      t.float :year_rate
      t.string :unit_price_unit
      t.float :term_length
      t.string :term_unit
      t.string :account_key

      t.timestamps
    end
    
    add_index :template_items, :pub_key
    add_index :template_items, :template_key
    add_index :template_items, :catalog_item_key
    add_index :template_items, :account_key
  end
end
