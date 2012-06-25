class AddTermLengthToDocumentItems < ActiveRecord::Migration
  def change
    add_column :document_items, :term_length, :float
    add_column :document_items, :term_unit, :string
    add_column :document_items, :unit_price_unit, :string
    
    add_column :catalog_items, :list_price_unit, :string
    add_column :catalog_items, :day_rate, :float
    add_column :catalog_items, :week_rate, :float
    add_column :catalog_items, :month_rate, :float
  end
end
