class Member < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :account
  belongs_to :user
  
  before_create :generate_keys
  
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
end
