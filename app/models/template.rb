class Template < ActiveRecord::Base
  attr_accessible :is_disabled, :is_document_type_default, :name, :pub_key, :document_type_key, :document_type, :total_purchase, :total_hourly, :total_daily, :total_monthly, :total_quarterly, :total_yearlt, :total_weekly, :description
  
  # belongs_to :account, :primary_key => "pub_key", :foreign_key => "account_key"
  has_many :template_items, dependent: :destroy, :primary_key => "pub_key", :foreign_key => "template_key"
  belongs_to :document_type, :primary_key => "pub_key", :foreign_key => "document_type_key"
  
  before_create :generate_keys
  
  validates :name, presence: true
  validates :account_key, presence: true
  # validates :document_type_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  
  def self.find_by_name_or_item(flt)
    self.where("templates.name ILIKE ?",'%'+flt+'%') + self.with_item_by_name_or_part_number(flt)
  end
  
  def self.with_item_by_name_or_part_number(value)
    self.where("templates.pub_key IN (SELECT template_key FROM template_items WHERE template_items.name ILIKE ? OR part_number ILIKE ?)",'%'+value+'%',value+'%')
  end
  
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