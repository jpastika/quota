class AddCompanyKeyToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :company_key, :string
  end
end
