class Milestone < ActiveRecord::Base
  attr_accessible :account_key, :is_disabled, :name, :probability, :pub_key
  attr_accessible :is_disabled, :name, :pub_key, :probability
  
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :probability, presence: true
  validates :account_key, presence: true
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Milestone.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
