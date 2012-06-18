class SalesRep < ActiveRecord::Base
  attr_accessible :account_key, :email, :is_disabled, :member_key, :name

  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :member, :primary_key => "pub_key", :foreign_key => "member_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while SalesRep.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
    
    
end