class AddPubKeyToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :pub_key, :string
    
    add_index :opportunities, :pub_key
    add_index :opportunities, :company_key
  end
end
