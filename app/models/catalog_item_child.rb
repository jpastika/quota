class CatalogItemChild < ActiveRecord::Base
  attr_accessible :account_key, :child_key, :parent_key, :pub_key, :child_item
  
  belongs_to :parent_item, :class_name => "CatalogItem", :primary_key => "pub_key", :foreign_key => "parent_key"
  belongs_to :child_item, :class_name => "CatalogItem", :primary_key => "pub_key", :foreign_key => "child_key"
  
  before_create :generate_keys
  
  validates :account_key, presence: true
  
  default_scope { where(account_key: Account.current_account_key) }
  
  private
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while CatalogItemChild.exists?(column => self[column])
    end
  
    def generate_keys
      generate_token(:pub_key)
    end
end
  