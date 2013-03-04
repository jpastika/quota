class Contact < ActiveRecord::Base
  attr_accessible :company_key, :is_disabled, :name, :pub_key, :title, :is_company
  
  # belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :company, :class_name => "Contact", :primary_key => "pub_key", :foreign_key => "company_key"
  # has_one :contact_type, :primary_key => "contact_type_key", :foreign_key => "pub_key"
  
  has_many :people, :class_name => "Contact", :primary_key => "pub_key", :foreign_key => "company_key"
  has_many :phones, dependent: :destroy, :class_name => "ContactPhone", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :emails, dependent: :destroy, :class_name => "ContactEmail", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :urls, dependent: :destroy, :class_name => "ContactUrl", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :addresses, dependent: :destroy, :class_name => "ContactAddress", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :opportunity_contacts, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "contact_key"
  
  # scope :companies, where(:contact_type_key => (ContactType.find_by_name("Company").pub_key unless ContactType.find_by_name("Company").nil?))
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  # validates :contact_type_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  
  class << self
    # def companies(account)
    #       where(:contact_type_key => (ContactType.where(:name => "Company", :account_key => account.pub_key).first.pub_key unless ContactType.where(:name => "Company", :account_key => account.pub_key).nil?))
    #     end
    
    def companies()
      # where(:contact_type_key => (ContactType.where(:name => "Company").first.pub_key unless ContactType.where(:name => "Company").nil?))
      where(:is_company => true)
    end
    
    def companies_find_by_name(flt)
      where("contacts.name ILIKE ? AND is_company = true",'%'+flt+'%')
    end

    
    
    # def people(account)
    #       where(:contact_type_key => (ContactType.where(:name => "Person", :account_key => account.pub_key).first.pub_key unless ContactType.where(:name => "Person", :account_key => account.pub_key).nil?))
    #     end
    
    def people()
      # where(:contact_type_key => (ContactType.where(:name => "Person").first.pub_key unless ContactType.where(:name => "Person").nil?))
      where(:is_company => false)
    end
  end
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Contact.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
    
    
  
end
