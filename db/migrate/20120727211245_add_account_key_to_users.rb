class AddAccountKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_key, :string
    add_index :users, :account_key
    
  end
end
