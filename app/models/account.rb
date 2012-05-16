class Account < ActiveRecord::Base
  attr_accessible :name, :subdomain
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  
  before_create :generate_keys
  before_save { |account| account.subdomain = subdomain.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_SUBDOMAIN_REGEX = /\A[a-z\d\-_]+\z/i
  validates :subdomain, presence: true, format: { with: VALID_SUBDOMAIN_REGEX }, uniqueness: { case_sensitive: false }
  
  
  
  def memberize!(user)
    members.create!(user_id: user.id)
  end
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Account.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
