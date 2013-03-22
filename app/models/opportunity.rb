class Opportunity < ActiveRecord::Base
  attr_accessible :estimated_close, :estimated_value, :estimated_value_interval, :actual_close, :milestone_key, :name, :owner_key, :probability, :creator_key, :account_key, :company_key, :company, :description, :actual_cancel, :is_sold, :is_cancelled, :is_disabled, :oem_key, :oem_rep_key
  
  # belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :owner, :class_name => "User", :primary_key => "pub_key", :foreign_key => "owner_key"
  belongs_to :created_by, :class_name => "User", :primary_key => "pub_key", :foreign_key => "creator_key"
  belongs_to :company, :class_name => "Contact", :primary_key => "pub_key", :foreign_key => "company_key"
  # has_many :quotes, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "opportunity_key"
  has_many :documents, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "opportunity_key"
  has_many :opportunity_contacts, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "opportunity_key"
  has_many :contacts, through: :opportunity_contacts, :source => :contact
  has_one :milestone, :primary_key => "milestone_key", :foreign_key => "pub_key"
  
  # default_scope where(account_key: Account.current_account_key).includes(:milestone).order("name ASC")
  default_scope { where(account_key: Account.current_account_key) }
  
  
  
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  # validates :creator_key, presence: true
  #   validates :owner_key, presence: true
  
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
