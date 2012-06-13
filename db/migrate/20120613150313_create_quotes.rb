class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :name
      t.boolean :is_draft
      t.string :company_key
      t.string :contact_key
      t.string :reference_id
      t.string :rep_key
      t.string :po
      t.string :company_name
      t.string :compoany_phone
      t.string :company_fax
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.string :shipping_street1
      t.stirng :shipping_street2
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip
      t.string :shipping_county
      t.string :shipping_country
      t.string :billing_street1
      t.string :billing_street2
      t.string :billing_city
      t.string :billing_state
      t.string :billing_zip
      t.string :billing_county
      t.string :billing_country
      t.float :total_recurring_monthly
      t.float :total_recurring_yearly
      t.float :total_subtotal
      t.float :total_tax
      t.float :total_tax_percent
      t.float :total_shipping_handling
      t.float :total_grand
      t.text :notes_customer
      t.text :notes_internal
      t.string :account_key
      t.string :opportunity_key
      t.string :creator_key
      t.string :pub_key

      t.timestamps
    end
    
    add_index :quotes, :pub_key
    add_index :quotes, :creator_key
    add_index :quotes, :account_key
    add_index :quotes, :opportunity_key
    add_index :quotes, :company_key
    add_index :quotes, :contact_key
  end
end
