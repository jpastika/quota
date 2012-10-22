class ContactType < ActiveRecord::Base
  attr_accessible :icon_class, :is_default, :is_disabled, :name, :pub_key
  
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while ContactType.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end