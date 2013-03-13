class CreateOems < ActiveRecord::Migration
  def change
    create_table :oems do |t|
      t.string :name
      t.string :pub_key
      t.string :account_key
      t.boolean :is_disabled

      t.timestamps
    end
    
    add_index :oems, :pub_key
    add_index :oems, :account_key
  end
end
