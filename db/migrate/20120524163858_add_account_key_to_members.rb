class AddAccountKeyToMembers < ActiveRecord::Migration
  def change
    remove_index :members, [:account_id, :user_id]
    remove_index :members, :account_id
    remove_index :members, :user_id
    
    remove_column :members, :account_id
    remove_column :members, :user_id
    
    add_column :members, :account_key, :string
    add_column :members, :user_key, :string
    
    add_index :members, :account_key
    add_index :members, :user_key
    add_index :members, [:account_key, :user_key]
  end
end
