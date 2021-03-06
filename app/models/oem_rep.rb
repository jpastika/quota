class OemRep < ActiveRecord::Base
  attr_accessible :name, :phone, :email, :oem_key, :is_disabled, :pub_key
  
  belongs_to :oem, :primary_key => "pub_key", :foreign_key => "oem_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  # validates :contact_type_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  
  class << self
    
  end
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while OemRep.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
