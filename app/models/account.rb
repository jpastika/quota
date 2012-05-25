class Account < ActiveRecord::Base
  attr_accessible :name, :subdomain, :members, :users, :users_attributes
  has_many :members, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :users, through: :members
  has_many :catalog_items, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :opportunities, :primary_key => "pub_key", :foreign_key => "account_key"
  
  accepts_nested_attributes_for :users
  
  before_create :generate_keys
  before_save { |account| account.subdomain = subdomain.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_SUBDOMAIN_REGEX = /\A[a-z\d\-_]+\z/i
  validates :subdomain, presence: true, format: { with: VALID_SUBDOMAIN_REGEX }, uniqueness: { case_sensitive: false }
  
  
  def memberize!(user)
    members.create!(user_key: user.pub_key)
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
