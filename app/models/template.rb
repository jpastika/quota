class Template < ActiveRecord::Base
  attr_accessible :is_disabled, :is_document_type_default, :name, :pub_key, :document_type_key, :document_type
  
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :template_items, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "template_key"
  belongs_to :document_type, :primary_key => "pub_key", :foreign_key => "document_type_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  # validates :document_type_key, presence: true
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Template.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end