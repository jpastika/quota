class Member < ActiveRecord::Base
  attr_accessible :user_key, :is_disabled, :user_attributes
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :user, :primary_key => "pub_key", :foreign_key => "user_key"
  has_many :owned_opportunities, :class_name => "Opportunity", :primary_key => "pub_key", :foreign_key => "owner_key"
  has_many :created_opportunities, :class_name => "Opportunity", :primary_key => "pub_key", :foreign_key => "creator_key"
  has_many :created_quotes, :class_name => "Quote", :primary_key => "pub_key", :foreign_key => "creator_key"
  has_many :owned_opportunity_quotes, through: :owned_opportunities, :source => :quotes
  has_one :sales_rep, :primary_key => "pub_key", :foreign_key => "member_key"
  
  scope :enabled, where('is_disabled != true')
  
  accepts_nested_attributes_for :user
  
  before_create :generate_keys
  before_save :create_remember_token
  
  
  validates :account_key, presence: true
  validates :user_key, presence: true
  
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
