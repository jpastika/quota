class Document < ActiveRecord::Base
  attr_accessible :account, :account_key, :billing_city, :billing_country, :billing_county, :billing_state, :billing_street1, :billing_street2, :billing_zip, :company_fax, :company_key, :company_name, :company_phone, :contact_email, :contact_key, :contact_name, :contact_phone, :creator_key, :is_draft, :name, :notes_customer, :notes_internal, :opportunity_key, :po, :reference_id, :rep_key, :shipping_city, :shipping_country, :shipping_county, :shipping_state, :shipping_street1, :shipping_street2, :shipping_zip, :total_grand, :total_recurring_monthly, :total_recurring_yearly, :total_shipping_handling, :total_subtotal, :total_tax, :total_tax_percent, :document_type_key, :document_type, :template_key, :company, :contact
  
  # belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :created_by, :class_name => "User", :primary_key => "pub_key", :foreign_key => "creator_key"
  belongs_to :opportunity, :primary_key => "pub_key", :foreign_key => "opportunity_key"
  belongs_to :company, :class_name => "Contact", :primary_key => "pub_key", :foreign_key => "company_key"
  belongs_to :contact, :class_name => "Contact", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :document_items, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "document_key"
  has_many :items, dependent: :destroy, :class_name => "DocumentItem", :primary_key => "pub_key", :foreign_key => "document_key"
  belongs_to :document_type, :primary_key => "pub_key", :foreign_key => "document_type_key"
  
  scope :quotes, where(:document_type => (DocumentType.find_by_name("Quote")))
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  validates :creator_key, presence: true
  validates :opportunity_key, presence: true
  # validates :document_type_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  class << self
    def search(flt)
      # where("name ILIKE ?",'%'+flt+'%')
      where("name ILIKE ? OR (company_key IN (SELECT pub_key FROM contacts WHERE name ILIKE ? AND is_company = true))",'%'+flt+'%',flt+'%')
    end
    
    def search_name(flt)
      where("name ILIKE ?",'%'+flt+'%')
    end
    
    def search_opportunity_name(flt)
      where("opportunity_key IN (SELECT pub_key FROM opportunities WHERE name ILIKE ?)",'%'+flt+'%')
    end
    
    def search_opportunity_company_name(flt)
      where("opportunity_key IN (SELECT pub_key FROM opportunities WHERE company_key IN (SELECT pub_key FROM contacts WHERE name ILIKE ? AND is_company = true))",'%'+flt+'%')
    end
    
    def search_po(flt)
      where("po ILIKE ?",flt+'%')
    end
    
    def search_part_number(flt)
      where("pub_key IN (SELECT document_key FROM document_items WHERE part_number ILIKE ?)",'%'+flt+'%')
    end
    
    def search_part_name(flt)
      where("pub_key IN (SELECT document_key FROM document_items WHERE name ILIKE ?)",'%'+flt+'%')
    end
  end
  
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
