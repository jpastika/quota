class CreateDocumentTypes < ActiveRecord::Migration
  def change
    create_table :document_types do |t|
      t.string :name
      t.boolean :is_disabled, :default => false
      t.string :account_key
      t.string :pub_key
      t.text :description

      t.timestamps
    end
    
    add_index :document_types, :pub_key
    add_index :document_types, :name
    add_index :document_types, :account_key
  end
end
