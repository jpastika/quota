class TemplateItem < ActiveRecord::Base
  attr_accessible :buyout, :catalog_item_key, :day_rate, :description, :discount, :document_item_type_key, :is_disabled, :is_discountable, :is_hidden, :is_taxable, :month_rate, :name, :notes, :parent_item_key, :part_number, :pub_key, :quantity, :sort_order, :template_key, :term_length, :term_unit, :total, :unit_price, :unit_price_unit, :week_rate, :year_rate, :is_group_heading, :not_in_total, :hide_package_contents
  
  # belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :template, :primary_key => "pub_key", :foreign_key => "template_key"
  belongs_to :parent_item, :class_name => "TemplateItem", :primary_key => "pub_key", :foreign_key => "parent_item_key"
  belongs_to :catalog_item, :primary_key => "pub_key", :foreign_key => "catalog_item_key"
  belongs_to :document_item_type, :primary_key => "pub_key", :foreign_key => "document_item_type_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  validates :template_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while TemplateItem.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end