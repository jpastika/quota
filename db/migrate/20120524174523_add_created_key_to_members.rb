class AddCreatedKeyToMembers < ActiveRecord::Migration
  def change
    add_column :members, :created_key, :string
    
    add_index :members, :created_key
  end
end
