class Document < ActiveRecord::Base
  attr_accessible :account, :account_key, :billing_city, :billing_country, :billing_county, :billing_state, :billing_street1, :billing_street2, :billing_zip, :company_fax, :company_key, :company_name, :company_phone, :contact_email, :contact_key, :contact_name, :contact_phone, :creator_key, :is_draft, :name, :notes_customer, :notes_internal, :opportunity_key, :po, :reference_id, :rep_key, :shipping_city, :shipping_country, :shipping_county, :shipping_state, :shipping_street1, :shipping_street2, :shipping_zip, :total_grand, :total_recurring_monthly, :total_recurring_yearly, :total_shipping_handling, :total_subtotal, :total_tax, :total_tax_percent, :document_type_key, :document_type
  
  # belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :created_by, :class_name => "User", :primary_key => "pub_key", :foreign_key => "creator_key"
  belongs_to :opportunity, :primary_key => "pub_key", :foreign_key => "opportunity_key"
  has_many :document_items, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "document_key"
  belongs_to :document_type, :primary_key => "pub_key", :foreign_key => "document_type_key"
  
  scope :quotes, where(:document_type => (DocumentType.find_by_name("Quote")))
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  validates :creator_key, presence: true
  validates :opportunity_key, presence: true
  # validates :document_type_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Document.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
