class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.boolean :is_draft
      t.string :account_key
      t.string :creator_key
      t.string :opportunity_key
      t.string :pub_key

      t.timestamps
    end
    add_index :documents, :pub_key
    add_index :documents, :creator_key
    add_index :documents, :account_key
    
    add_index :opportunities, :account_key
  end
end
