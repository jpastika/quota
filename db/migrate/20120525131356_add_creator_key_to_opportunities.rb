class AddCreatorKeyToOpportunities < ActiveRecord::Migration
  def change
    remove_index :opportunities, :created_key
    remove_column :opportunities, :created_key
    
    add_column :opportunities, :creator_key, :string
    add_index :opportunities, :creator_key
  end
end
