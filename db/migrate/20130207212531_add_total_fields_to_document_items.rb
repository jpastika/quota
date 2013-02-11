class AddTotalFieldsToDocumentItems < ActiveRecord::Migration
  def change
    add_column :document_items, :total_unit, :string
    add_column :document_items, :is_group_heading, :boolean, :default => false
    add_column :document_items, :not_in_total, :boolean, :default => false
    add_column :document_items, :hide_package_contents, :boolean, :default => false
  end
end