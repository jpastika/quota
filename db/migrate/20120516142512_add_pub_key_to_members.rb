class AddPubKeyToMembers < ActiveRecord::Migration
  def change
    add_column :members, :pub_key, :string
    
    add_index :members, :pub_key, unique: true
  end
end
