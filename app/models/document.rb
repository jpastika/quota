class Document < ActiveRecord::Base
  attr_accessible :account_key, :is_draft, :name, :opportunity_key, :creator_key, :pub_key
  
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :created_by, :class_name => "Member", :primary_key => "pub_key", :foreign_key => "creator_key"
  belongs_to :opportunity, :primary_key => "pub_key", :foreign_key => "opportunity_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  validates :creator_key, presence: true
  validates :opportunity_key, presence: true
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Document.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
