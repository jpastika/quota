class Contact < ActiveRecord::Base
  attr_accessible :company_key, :contact_type_key, :is_disabled, :name, :pub_key, :title
  
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :company, :class_name => "Contact", :primary_key => "pub_key", :foreign_key => "company_key"
  belongs_to :contact_type, :primary_key => "pub_key", :foreign_key => "contact_type_key"
  
  has_many :people, :class_name => "Contact", :primary_key => "pub_key", :foreign_key => "company_key"
  has_many :phones, :class_name => "ContactPhone", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :emails, :class_name => "ContactEmail", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :urls, :class_name => "ContactUrl", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :addresses, :class_name => "ContactAddress", :primary_key => "pub_key", :foreign_key => "contact_key"
  
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  validates :contact_type_key, presence: true
  
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
