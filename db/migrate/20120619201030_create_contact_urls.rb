class CreateContactUrls < ActiveRecord::Migration
  def change
    create_table :contact_urls do |t|
      t.string :name
      t.string :val
      t.string :pub_key
      t.string :contact_key
      t.string :account_key
      t.boolean :is_disabled, :default => false

      t.timestamps
    end
    
    add_index :contact_urls, :pub_key
    add_index :contact_urls, :contact_key
    add_index :contact_urls, :account_key
  end
end
