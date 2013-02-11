class CatalogItem < ActiveRecord::Base
  attr_accessible :cost, :description, :manufacturer, :is_recurring, :is_subscription, :is_taxable, :list_price, :name, :part_number, :pub_key, :recurring_unit, :subscription_length, :subscription_length_unit, :list_price_unit, :day_rate, :week_rate, :month_rate, :is_package
  
  # belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  # 
  has_many :catalog_item_children, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "parent_key"
  has_many :child_items, through: :catalog_item_children, :source => :child_item
  
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  def self.find_by_name_or_part_number(flt)
    self.where("catalog_items.name ILIKE ? OR catalog_items.part_number ILIKE ?",'%'+flt+'%',flt+'%')
  end
  
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
