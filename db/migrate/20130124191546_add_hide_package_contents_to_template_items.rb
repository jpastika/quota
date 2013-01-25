class AddHidePackageContentsToTemplateItems < ActiveRecord::Migration
  def change
    add_column :template_items, :hide_package_contents, :boolean, :default => false
  end
end
