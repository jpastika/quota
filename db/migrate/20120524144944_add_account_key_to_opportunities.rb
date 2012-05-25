class AddAccountKeyToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :account_key, :string
  end
end
