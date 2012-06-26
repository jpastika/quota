class ChangeDocumentItemTypeToDocumentItemTypeKeyOnDocumentItems < ActiveRecord::Migration
  def change
    remove_column :document_items, :document_item_type
    
    add_column :document_items, :document_item_type_key, :string
  end
end
