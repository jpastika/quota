class AddPubKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pub_key, :string
    
    add_index :users, :pub_key, unique: true
  end
end
