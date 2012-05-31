class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :is_disabled, :members, :accounts
  has_secure_password
  
  has_many :members, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "user_key"
  has_many :accounts, through: :members
  
  before_create :generate_keys
  before_save { |user| user.email = email.downcase }
  
  
  
  #validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
  
  #validates :password_confirmation, presence: true
  
  
  
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
