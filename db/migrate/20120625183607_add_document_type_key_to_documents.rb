class AddDocumentTypeKeyToDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :document_type
    add_column :documents, :document_type_key, :string
    add_index :documents, :document_type_key
    
    change_column :templates, :is_disabled, :boolean, :default => false
    change_column :templates, :is_document_type_default, :boolean, :default => false
  end
end
