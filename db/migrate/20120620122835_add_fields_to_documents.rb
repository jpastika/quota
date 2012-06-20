class AddFieldsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :is_disabled, :boolean, :default => false
    add_column :documents, :company_key, :string
    add_column :documents, :contact_key, :string
    add_column :documents, :reference_id, :string
    add_column :documents, :rep_key, :string
    add_column :documents, :po, :string
    add_column :documents, :company_name, :string
    add_column :documents, :company_phone, :string
    add_column :documents, :company_fax, :string
    add_column :documents, :contact_name, :string
    add_column :documents, :contact_phone, :string
    add_column :documents, :contact_email, :string
    add_column :documents, :shipping_street1, :string
    add_column :documents, :shipping_street2, :string
    add_column :documents, :shipping_city, :string
    add_column :documents, :shipping_state, :string
    add_column :documents, :shipping_zip, :string
    add_column :documents, :shipping_county, :string
    add_column :documents, :shipping_country, :string
    add_column :documents, :billing_street1, :string
    add_column :documents, :billing_street2, :string
    add_column :documents, :billing_city, :string
    add_column :documents, :billing_state, :string
    add_column :documents, :billing_zip, :string
    add_column :documents, :billing_county, :string
    add_column :documents, :billing_country, :string
    add_column :documents, :total_recurring_monthly, :float
    add_column :documents, :total_recurring_yearly, :float
    add_column :documents, :total_subtotal, :float
    add_column :documents, :total_tax, :float
    add_column :documents, :total_tax_percent, :float
    add_column :documents, :total_shipping_handling, :float
    add_column :documents, :total_grand, :float
    add_column :documents, :notes_customer, :text
    add_column :documents, :notes_internal, :text
    
    add_index :documents, :company_key
    add_index :documents, :contact_key
  end
end
