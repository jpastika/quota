class Contact < ActiveRecord::Base
  attr_accessible :company_key, :contact_type_key, :is_disabled, :name, :pub_key, :title
  
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :company, :class_name => "Contact", :primary_key => "pub_key", :foreign_key => "company_key"
  belongs_to :contact_type, :primary_key => "pub_key", :foreign_key => "contact_type_key"
  
  has_many :people, :class_name => "Contact", :primary_key => "pub_key", :foreign_key => "company_key"
  has_many :phones, dependent: :destroy, :class_name => "ContactPhone", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :emails, dependent: :destroy, :class_name => "ContactEmail", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :urls, dependent: :destroy, :class_name => "ContactUrl", :primary_key => "pub_key", :foreign_key => "contact_key"
  has_many :addresses, dependent: :destroy, :class_name => "ContactAddress", :primary_key => "pub_key", :foreign_key => "contact_key"
  
  scope :companies, where(:contact_type_key => (ContactType.find_by_name("Company").pub_key unless ContactType.find_by_name("Company").nil?))
  
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
