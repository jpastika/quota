class DocumentItem < ActiveRecord::Base
  attr_accessible :buyout, :catalog_item_key, :day_rate, :description, :discount, :document_item_type_key, :document_key, :is_disabled, :is_discountable, :is_hidden, :is_taxable, :month_rate, :name, :notes, :parent_item_key, :part_number, :quantity, :serial_number, :sort_order, :total, :unit_price, :week_rate, :pub_key, :year_rate, :unit_price_unit, :term_length, :term_unit, :document_item_type_key, :total, :week_rate, :year_rate, :is_group_heading, :not_in_total, :hide_package_contents, :total_unit
  
  # belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :document, :primary_key => "pub_key", :foreign_key => "document_key"
  belongs_to :parent_item, :class_name => "DocumentItem", :primary_key => "pub_key", :foreign_key => "parent_item_key"
  belongs_to :catalog_item, :primary_key => "pub_key", :foreign_key => "catalog_item_key"
  belongs_to :document_item_type, :primary_key => "pub_key", :foreign_key => "document_item_type_key"
  
  # scope :quotes, where(:document_item_type => "Quote")
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  validates :document_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while DocumentItem.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end