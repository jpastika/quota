class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.string :document_type_key
      t.boolean :is_disabled
      t.boolean :is_document_type_default
      t.string :account_key
      t.string :pub_key

      t.timestamps
    end
    add_index :templates, :pub_key
    add_index :templates, :document_type_key
    add_index :templates, :account_key
  end
end
