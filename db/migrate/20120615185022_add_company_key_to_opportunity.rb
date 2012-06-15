class AddCompanyKeyToOpportunity < ActiveRecord::Migration
  def change
    add_column :opportunities, :company_key, :string
    
    add_index :opportunities, :company_key
  end
end
