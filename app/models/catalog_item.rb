class CatalogItem < ActiveRecord::Base
  attr_accessible :cost, :description, :is_recurring, :is_subscription, :is_taxable, :list_price, :name, :part_number, :pub_key, :recurring_unit, :subscription_length, :subscription_length_unit
  belongs_to :account
  
  before_create :generate_keys
  
  validates :name, presence: true
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while CatalogItem.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
