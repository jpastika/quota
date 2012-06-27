class CreateDocumentItemTypes < ActiveRecord::Migration
  def change
    create_table :document_item_types do |t|
      t.string :name
      t.string :pub_key
      t.boolean :is_disabled
      t.string :account_key

      t.timestamps
    end
    
    add_index :document_item_types, :pub_key
    add_index :document_item_types, :name
    add_index :document_item_types, :account_key
  end
end
