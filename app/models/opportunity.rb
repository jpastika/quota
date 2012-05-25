class Opportunity < ActiveRecord::Base
  attr_accessible :estimated_close, :milestone, :name, :owner_key, :probability, :created_key
  
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :owner, :class_name => "Member", :primary_key => "pub_key", :foreign_key => "owner_key"
  belongs_to :created_by, :class_name => "Member", :primary_key => "pub_key", :foreign_key => "created_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Opportunity.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end