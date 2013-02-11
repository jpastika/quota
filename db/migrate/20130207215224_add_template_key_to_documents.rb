class AddTemplateKeyToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :template_key, :string
  end
end
