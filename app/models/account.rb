class Account < ActiveRecord::Base
  attr_accessible :name, :subdomain, :is_disabled, :members, :users, :users_attributes
  has_many :members, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :sales_reps, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :users, through: :members
  has_many :catalog_items, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :opportunities, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  # has_many :quotes, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :documents, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :document_items, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :contacts, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :contact_phones, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :contact_emails, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :contact_urls, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :contact_addresses, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :document_types, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key", :order => 'name'
  has_many :templates, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :template_items, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :document_item_types, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key", :order => 'name'
  has_many :contact_types, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key", :order => 'name'
  
  accepts_nested_attributes_for :users
  
  before_create :generate_keys
  before_save { |account| account.subdomain = subdomain.downcase }
  
  after_create :generate_data
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_SUBDOMAIN_REGEX = /\A[a-z\d\-_]+\z/i
  validates :subdomain, presence: true, format: { with: VALID_SUBDOMAIN_REGEX }, uniqueness: { case_sensitive: false }
  
  
  def memberize!(user)
    members.create!(user_key: user.pub_key)
  end
  
  def repize!(member)
    sales_reps.create!(member_key: member.pub_key, name: member.user.name, email: member.user.email)
  end
  
  
  
  def generate_default_templates
    self.document_types.each do |doc_type|
      self.templates.create!(name: doc_type.name, document_type: doc_type, is_document_type_default: true)
    end
  end
  
  def generate_document_item_types
    self.document_item_types.create!(name: "Product")
    self.document_item_types.create!(name: "Service")
    self.document_item_types.create!(name: "Rental")
    self.document_item_types.create!(name: "Subscription")
    self.document_item_types.create!(name: "Credit")
    self.document_item_types.create!(name: "Trade-In")
    self.document_item_types.create!(name: "Header")
  end
  
  def generate_contact_types
    self.contact_types.create!(name: "Person", icon_class: "icon-user", is_default: true)
    self.contact_types.create!(name: "Company", icon_class: "icon-reorder")
  end
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Account.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
    
    def generate_data
      generate_document_types
      generate_default_templates
      generate_document_item_types
      generate_contact_types
    end
    
    def generate_document_types
      self.document_types.create!(name: "Quote")
      self.document_types.create!(name: "Sale")
      self.document_types.create!(name: "Rental")
      self.document_types.create!(name: "Proposal")
    end
    
    
    
    
    
end
