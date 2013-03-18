class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :is_disabled, :members, :accounts
  cattr_accessor :current_user_key
  
  has_secure_password
  
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :owned_opportunities, :class_name => "Opportunity", :primary_key => "pub_key", :foreign_key => "owner_key"
  has_many :created_opportunities, :class_name => "Opportunity", :primary_key => "pub_key", :foreign_key => "creator_key"
  # has_many :created_quotes, :class_name => "Quote", :primary_key => "pub_key", :foreign_key => "creator_key"
  has_many :created_documents, :class_name => "Document", :primary_key => "pub_key", :foreign_key => "creator_key"
  has_many :owned_opportunity_documents, through: :owned_opportunities, :source => :documents
  has_one :sales_rep, :primary_key => "pub_key", :foreign_key => "user_key"
  
  scope :enabled, where('is_disabled != true')
  
  before_create :generate_keys
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  
  
  #validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: { on: create }, length: { minimum: 6}, :if => :password_digest_changed?
  # validates :account_key, presence: true
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
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end



# 
# 
# 
# class Member < ActiveRecord::Base
#   attr_accessible :user_key, :is_disabled, :user_attributes
#   belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
#   belongs_to :user, :primary_key => "pub_key", :foreign_key => "user_key"
#   has_many :owned_opportunities, :class_name => "Opportunity", :primary_key => "pub_key", :foreign_key => "owner_key"
#   has_many :created_opportunities, :class_name => "Opportunity", :primary_key => "pub_key", :foreign_key => "creator_key"
#   # has_many :created_quotes, :class_name => "Quote", :primary_key => "pub_key", :foreign_key => "creator_key"
#   has_many :created_documents, :class_name => "Document", :primary_key => "pub_key", :foreign_key => "creator_key"
#   has_many :owned_opportunity_documents, through: :owned_opportunities, :source => :documents
#   has_one :sales_rep, :primary_key => "pub_key", :foreign_key => "member_key"
#   
#   scope :enabled, where('is_disabled != true')
#   
#   accepts_nested_attributes_for :user
#   
#   before_create :generate_keys
#   before_save :create_remember_token
#   
#   
#   validates :account_key, presence: true
#   validates :user_key, presence: true
#   
#   private
#     def generate_token(column)
#       begin
#         self[column] = SecureRandom.urlsafe_base64
#       end while Member.exists?(column => self[column])
#     end
#   
#     def generate_keys
#       generate_token(:pub_key)
#     end
#     
#     def create_remember_token
#       self.remember_token = SecureRandom.urlsafe_base64
#     end
# end

