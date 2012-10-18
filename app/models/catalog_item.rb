class CatalogItem < ActiveRecord::Base
  attr_accessible :cost, :description, :manufacturer, :is_recurring, :is_subscription, :is_taxable, :list_price, :name, :part_number, :pub_key, :recurring_unit, :subscription_length, :subscription_length_unit, :list_price_unit, :day_rate, :week_rate, :month_rate
  
  belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :list_price, presence: true
  validates :account_key, presence: true
  
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
