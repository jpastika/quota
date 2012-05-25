class AddCreatedKeyToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :created_key, :string
    add_index :opportunities, :created_key
  end
end
