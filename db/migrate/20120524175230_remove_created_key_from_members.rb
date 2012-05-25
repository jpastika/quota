class RemoveCreatedKeyFromMembers < ActiveRecord::Migration
  def change
    remove_index :members, :created_key
    remove_column :members, :created_key
    
    
  end
end
