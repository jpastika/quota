class CreateCatalogItems < ActiveRecord::Migration
  def change
    create_table :catalog_items do |t|
      t.string :name
      t.string :part_number
      t.string :manufacturer
      t.text :description
      t.float :list_price
      t.float :cost
      t.boolean :is_recurring
      t.string :recurring_unit
      t.boolean :is_taxable
      t.boolean :is_subscription
      t.float :subscription_length
      t.string :subscription_length_unit
      t.string :pub_key
      t.references :account

      t.timestamps
    end
    add_index :catalog_items, :account_id
  end
end
