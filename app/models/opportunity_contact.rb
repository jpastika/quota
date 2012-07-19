class OpportunityContact < ActiveRecord::Base
  attr_accessible :account, :account_key, :contact, :contact_key, :opportunity, :opportunity_key, :is_disabled
  
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :opportunity, :primary_key => "pub_key", :foreign_key => "opportunity_key"
  belongs_to :contact, :primary_key => "pub_key", :foreign_key => "contact_key"
  
  before_create :generate_keys
  
  validates :account_key, presence: true
  validates :contact_key, presence: true
  validates :opportunity_key, presence: true
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while OpportunityContact.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
