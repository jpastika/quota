# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130313165535) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "pub_key"
    t.boolean  "is_disabled", :default => false
  end

  add_index "accounts", ["pub_key"], :name => "index_accounts_on_pub_key", :unique => true
  add_index "accounts", ["subdomain"], :name => "index_accounts_on_subdomain", :unique => true

  create_table "catalog_item_children", :force => true do |t|
    t.string   "account_key"
    t.string   "pub_key"
    t.string   "parent_key"
    t.string   "child_key"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.float    "quantity",    :default => 1.0
  end

  add_index "catalog_item_children", ["account_key"], :name => "index_catalog_item_children_on_account_key"
  add_index "catalog_item_children", ["child_key"], :name => "index_catalog_item_children_on_child_key"
  add_index "catalog_item_children", ["parent_key"], :name => "index_catalog_item_children_on_parent_key"

  create_table "catalog_items", :force => true do |t|
    t.string   "name"
    t.string   "part_number"
    t.string   "manufacturer"
    t.text     "description"
    t.float    "list_price"
    t.float    "cost"
    t.boolean  "is_recurring",             :default => false
    t.string   "recurring_unit"
    t.boolean  "is_taxable",               :default => false
    t.boolean  "is_subscription",          :default => false
    t.float    "subscription_length"
    t.string   "subscription_length_unit"
    t.string   "pub_key"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "account_key"
    t.string   "list_price_unit"
    t.float    "day_rate"
    t.float    "week_rate"
    t.float    "month_rate"
    t.boolean  "is_package",               :default => false
  end

  add_index "catalog_items", ["account_key"], :name => "index_catalog_items_on_account_key"

  create_table "contact_addresses", :force => true do |t|
    t.string   "name"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "county"
    t.string   "pub_key"
    t.string   "contact_key"
    t.string   "account_key"
    t.boolean  "is_disabled", :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "contact_addresses", ["account_key"], :name => "index_contact_addresses_on_account_key"
  add_index "contact_addresses", ["contact_key"], :name => "index_contact_addresses_on_contact_key"
  add_index "contact_addresses", ["pub_key"], :name => "index_contact_addresses_on_pub_key"

  create_table "contact_emails", :force => true do |t|
    t.string   "name"
    t.string   "val"
    t.string   "pub_key"
    t.string   "contact_key"
    t.string   "account_key"
    t.boolean  "is_disabled", :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "contact_emails", ["account_key"], :name => "index_contact_emails_on_account_key"
  add_index "contact_emails", ["contact_key"], :name => "index_contact_emails_on_contact_key"
  add_index "contact_emails", ["pub_key"], :name => "index_contact_emails_on_pub_key"

  create_table "contact_phones", :force => true do |t|
    t.string   "name"
    t.string   "val"
    t.string   "pub_key"
    t.string   "contact_key"
    t.boolean  "is_disabled", :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "account_key"
  end

  add_index "contact_phones", ["account_key"], :name => "index_contact_phones_on_account_key"
  add_index "contact_phones", ["contact_key"], :name => "index_contact_phones_on_contact_key"
  add_index "contact_phones", ["pub_key"], :name => "index_contact_phones_on_pub_key"

  create_table "contact_types", :force => true do |t|
    t.string   "name"
    t.boolean  "is_disabled", :default => false
    t.string   "account_key"
    t.string   "pub_key"
    t.string   "icon_class"
    t.boolean  "is_default",  :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "contact_types", ["account_key"], :name => "index_contact_types_on_account_key"
  add_index "contact_types", ["name"], :name => "index_contact_types_on_name"
  add_index "contact_types", ["pub_key"], :name => "index_contact_types_on_pub_key"

  create_table "contact_urls", :force => true do |t|
    t.string   "name"
    t.string   "val"
    t.string   "pub_key"
    t.string   "contact_key"
    t.string   "account_key"
    t.boolean  "is_disabled", :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "contact_urls", ["account_key"], :name => "index_contact_urls_on_account_key"
  add_index "contact_urls", ["contact_key"], :name => "index_contact_urls_on_contact_key"
  add_index "contact_urls", ["pub_key"], :name => "index_contact_urls_on_pub_key"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "pub_key"
    t.string   "account_key"
    t.string   "title"
    t.string   "company_key"
    t.boolean  "is_disabled",      :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "contact_type_key"
    t.boolean  "is_company",       :default => false
  end

  add_index "contacts", ["account_key"], :name => "index_contacts_on_account_key"
  add_index "contacts", ["company_key"], :name => "index_contacts_on_company_key"
  add_index "contacts", ["pub_key"], :name => "index_contacts_on_pub_key"

  create_table "document_item_types", :force => true do |t|
    t.string   "name"
    t.string   "pub_key"
    t.string   "account_key"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "is_disabled", :default => false
  end

  add_index "document_item_types", ["account_key"], :name => "index_document_item_types_on_account_key"
  add_index "document_item_types", ["name"], :name => "index_document_item_types_on_name"
  add_index "document_item_types", ["pub_key"], :name => "index_document_item_types_on_pub_key"

  create_table "document_items", :force => true do |t|
    t.string   "name"
    t.string   "part_number"
    t.float    "quantity"
    t.float    "unit_price"
    t.string   "discount"
    t.boolean  "is_taxable",             :default => true
    t.boolean  "is_discountable",        :default => true
    t.float    "total"
    t.text     "notes"
    t.integer  "sort_order"
    t.boolean  "is_hidden",              :default => false
    t.float    "day_rate"
    t.float    "week_rate"
    t.float    "month_rate"
    t.float    "buyout"
    t.string   "serial_number"
    t.text     "description"
    t.string   "pub_key"
    t.string   "document_key"
    t.string   "account_key"
    t.string   "catalog_item_key"
    t.boolean  "is_disabled",            :default => false
    t.string   "parent_item_key"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.float    "year_rate"
    t.float    "term_length"
    t.string   "term_unit"
    t.string   "unit_price_unit"
    t.string   "document_item_type_key"
    t.string   "total_unit"
    t.boolean  "is_group_heading",       :default => false
    t.boolean  "not_in_total",           :default => false
    t.boolean  "hide_package_contents",  :default => false
  end

  add_index "document_items", ["account_key"], :name => "index_document_items_on_account_key"
  add_index "document_items", ["catalog_item_key"], :name => "index_document_items_on_catalog_item_key"
  add_index "document_items", ["document_key"], :name => "index_document_items_on_document_key"
  add_index "document_items", ["pub_key"], :name => "index_document_items_on_pub_key"

  create_table "document_types", :force => true do |t|
    t.string   "name"
    t.boolean  "is_disabled", :default => false
    t.string   "account_key"
    t.string   "pub_key"
    t.text     "description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "document_types", ["account_key"], :name => "index_document_types_on_account_key"
  add_index "document_types", ["name"], :name => "index_document_types_on_name"
  add_index "document_types", ["pub_key"], :name => "index_document_types_on_pub_key"

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.boolean  "is_draft",                :default => true
    t.string   "account_key"
    t.string   "creator_key"
    t.string   "opportunity_key"
    t.string   "pub_key"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "is_disabled",             :default => false
    t.string   "company_key"
    t.string   "contact_key"
    t.string   "reference_id"
    t.string   "rep_key"
    t.string   "po"
    t.string   "company_name"
    t.string   "company_phone"
    t.string   "company_fax"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "shipping_street1"
    t.string   "shipping_street2"
    t.string   "shipping_city"
    t.string   "shipping_state"
    t.string   "shipping_zip"
    t.string   "shipping_county"
    t.string   "shipping_country"
    t.string   "billing_street1"
    t.string   "billing_street2"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_zip"
    t.string   "billing_county"
    t.string   "billing_country"
    t.float    "total_recurring_monthly"
    t.float    "total_recurring_yearly"
    t.float    "total_subtotal"
    t.float    "total_tax"
    t.float    "total_tax_percent"
    t.float    "total_shipping_handling"
    t.float    "total_grand"
    t.text     "notes_customer"
    t.text     "notes_internal"
    t.string   "document_type_key"
    t.string   "template_key"
  end

  add_index "documents", ["account_key"], :name => "index_documents_on_account_key"
  add_index "documents", ["company_key"], :name => "index_documents_on_company_key"
  add_index "documents", ["contact_key"], :name => "index_documents_on_contact_key"
  add_index "documents", ["creator_key"], :name => "index_documents_on_creator_key"
  add_index "documents", ["document_type_key"], :name => "index_documents_on_document_type_key"
  add_index "documents", ["pub_key"], :name => "index_documents_on_pub_key"

  create_table "members", :force => true do |t|
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "pub_key"
    t.string   "remember_token"
    t.string   "account_key"
    t.string   "user_key"
    t.boolean  "is_disabled",    :default => false
  end

  add_index "members", ["account_key", "user_key"], :name => "index_members_on_account_key_and_user_key"
  add_index "members", ["account_key"], :name => "index_members_on_account_key"
  add_index "members", ["pub_key"], :name => "index_members_on_pub_key", :unique => true
  add_index "members", ["remember_token"], :name => "index_members_on_remember_token"
  add_index "members", ["user_key"], :name => "index_members_on_user_key"

  create_table "milestones", :force => true do |t|
    t.string   "name"
    t.string   "pub_key"
    t.string   "account_key"
    t.float    "probability"
    t.boolean  "is_disabled"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "milestones", ["account_key"], :name => "index_milestones_on_account_key"
  add_index "milestones", ["pub_key"], :name => "index_milestones_on_pub_key"

  create_table "oem_reps", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "pub_key"
    t.string   "oem_key"
    t.string   "account_key"
    t.boolean  "is_disabled"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "oem_reps", ["account_key"], :name => "index_oem_reps_on_account_key"
  add_index "oem_reps", ["oem_key"], :name => "index_oem_reps_on_oem_key"
  add_index "oem_reps", ["pub_key"], :name => "index_oem_reps_on_pub_key"

  create_table "oems", :force => true do |t|
    t.string   "name"
    t.string   "pub_key"
    t.string   "account_key"
    t.boolean  "is_disabled"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "oems", ["account_key"], :name => "index_oems_on_account_key"
  add_index "oems", ["pub_key"], :name => "index_oems_on_pub_key"

  create_table "opportunities", :force => true do |t|
    t.string   "name"
    t.date     "estimated_close"
    t.string   "milestone_key"
    t.float    "probability"
    t.string   "owner_key"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "account_key"
    t.string   "pub_key"
    t.string   "creator_key"
    t.string   "company_key"
    t.float    "estimated_value"
    t.date     "actual_close"
    t.string   "estimated_value_interval"
    t.text     "description"
    t.boolean  "is_cancelled",             :default => false
    t.boolean  "is_sold",                  :default => false
    t.date     "actual_cancel"
    t.boolean  "is_disabled",              :default => false
    t.string   "oem_key"
    t.string   "oem_rep_key"
  end

  add_index "opportunities", ["account_key"], :name => "index_opportunities_on_account_key"
  add_index "opportunities", ["company_key"], :name => "index_opportunities_on_company_key"
  add_index "opportunities", ["creator_key"], :name => "index_opportunities_on_creator_key"
  add_index "opportunities", ["pub_key"], :name => "index_opportunities_on_pub_key"

  create_table "opportunity_contacts", :force => true do |t|
    t.string   "opportunity_key"
    t.string   "contact_key"
    t.string   "pub_key"
    t.string   "account_key"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "is_disabled",     :default => false
  end

  add_index "opportunity_contacts", ["account_key"], :name => "index_opportunity_contacts_on_account_key"
  add_index "opportunity_contacts", ["contact_key"], :name => "index_opportunity_contacts_on_contact_key"
  add_index "opportunity_contacts", ["opportunity_key"], :name => "index_opportunity_contacts_on_opportunity_key"

  create_table "quotes", :force => true do |t|
    t.string   "name"
    t.boolean  "is_draft",                :default => false
    t.string   "company_key"
    t.string   "contact_key"
    t.string   "reference_id"
    t.string   "rep_key"
    t.string   "po"
    t.string   "company_name"
    t.string   "company_phone"
    t.string   "company_fax"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "shipping_street1"
    t.string   "shipping_street2"
    t.string   "shipping_city"
    t.string   "shipping_state"
    t.string   "shipping_zip"
    t.string   "shipping_county"
    t.string   "shipping_country"
    t.string   "billing_street1"
    t.string   "billing_street2"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_zip"
    t.string   "billing_county"
    t.string   "billing_country"
    t.float    "total_recurring_monthly"
    t.float    "total_recurring_yearly"
    t.float    "total_subtotal"
    t.float    "total_tax"
    t.float    "total_tax_percent"
    t.float    "total_shipping_handling"
    t.float    "total_grand"
    t.text     "notes_customer"
    t.text     "notes_internal"
    t.string   "account_key"
    t.string   "opportunity_key"
    t.string   "creator_key"
    t.string   "pub_key"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "quotes", ["account_key"], :name => "index_quotes_on_account_key"
  add_index "quotes", ["company_key"], :name => "index_quotes_on_company_key"
  add_index "quotes", ["contact_key"], :name => "index_quotes_on_contact_key"
  add_index "quotes", ["creator_key"], :name => "index_quotes_on_creator_key"
  add_index "quotes", ["opportunity_key"], :name => "index_quotes_on_opportunity_key"
  add_index "quotes", ["pub_key"], :name => "index_quotes_on_pub_key"

  create_table "sales_reps", :force => true do |t|
    t.string   "name"
    t.string   "pub_key"
    t.string   "email"
    t.string   "account_key"
    t.boolean  "is_disabled", :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "user_key"
  end

  add_index "sales_reps", ["account_key"], :name => "index_sales_reps_on_account_key"
  add_index "sales_reps", ["pub_key"], :name => "index_sales_reps_on_pub_key"

  create_table "template_items", :force => true do |t|
    t.float    "buyout"
    t.string   "catalog_item_key"
    t.float    "day_rate"
    t.text     "description"
    t.float    "discount"
    t.string   "document_item_type_key"
    t.string   "template_key"
    t.boolean  "is_disabled",            :default => false
    t.boolean  "is_discountable",        :default => true
    t.boolean  "is_hidden",              :default => false
    t.boolean  "is_taxable",             :default => true
    t.float    "month_rate"
    t.string   "name"
    t.text     "notes"
    t.string   "parent_item_key"
    t.string   "part_number"
    t.float    "quantity"
    t.integer  "sort_order"
    t.float    "total"
    t.float    "unit_price"
    t.float    "week_rate"
    t.string   "pub_key"
    t.float    "year_rate"
    t.string   "unit_price_unit"
    t.float    "term_length"
    t.string   "term_unit"
    t.string   "account_key"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "is_group_heading",       :default => false
    t.boolean  "not_in_total",           :default => false
    t.boolean  "hide_package_contents",  :default => false
    t.string   "total_unit"
  end

  add_index "template_items", ["account_key"], :name => "index_template_items_on_account_key"
  add_index "template_items", ["catalog_item_key"], :name => "index_template_items_on_catalog_item_key"
  add_index "template_items", ["pub_key"], :name => "index_template_items_on_pub_key"
  add_index "template_items", ["template_key"], :name => "index_template_items_on_template_key"

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.string   "document_type_key"
    t.boolean  "is_disabled",              :default => false
    t.boolean  "is_document_type_default", :default => false
    t.string   "account_key"
    t.string   "pub_key"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.float    "total_purchase",           :default => 0.0
    t.float    "total_hourly",             :default => 0.0
    t.float    "total_daily",              :default => 0.0
    t.float    "total_weekly",             :default => 0.0
    t.float    "total_monthly",            :default => 0.0
    t.float    "total_quarterly",          :default => 0.0
    t.float    "total_yearly",             :default => 0.0
    t.text     "description"
  end

  add_index "templates", ["account_key"], :name => "index_templates_on_account_key"
  add_index "templates", ["document_type_key"], :name => "index_templates_on_document_type_key"
  add_index "templates", ["pub_key"], :name => "index_templates_on_pub_key"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "pub_key"
    t.string   "password_digest"
    t.boolean  "is_disabled",     :default => false
    t.string   "remember_token"
    t.string   "account_key"
  end

  add_index "users", ["account_key"], :name => "index_users_on_account_key"
  add_index "users", ["pub_key"], :name => "index_users_on_pub_key", :unique => true

end
