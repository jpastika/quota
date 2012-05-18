class Member < ActiveRecord::Base
  attr_accessible :user_id#, :user_attributes
  belongs_to :account
  belongs_to :user
  
  #accepts_nested_attributes_for :user
  
  before_create :generate_keys
  before_save :create_remember_token
  
  
  validates :account_id, presence: true
  validates :user_id, presence: true
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Member.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
