class ContactPhone < ActiveRecord::Base
  attr_accessible :contact_key, :name, :pub_key, :val, :is_disabled
  
  # belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :contact, :primary_key => "pub_key", :foreign_key => "contact_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  validates :contact_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while ContactPhone.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
