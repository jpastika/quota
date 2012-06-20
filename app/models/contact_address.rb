class ContactAddress < ActiveRecord::Base
  attr_accessible :city, :contact_key, :country, :county, :is_disabled, :name, :pub_key, :state, :street1, :street2, :zip

  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  belongs_to :contact, :primary_key => "pub_key", :foreign_key => "contact_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  validates :contact_key, presence: true
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while ContactAddress.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
