class AddIsGroupHeadingToTemplateItems < ActiveRecord::Migration
  def change
    add_column :template_items, :is_group_heading, :boolean, :default => false
    add_column :template_items, :not_in_total, :boolean, :default => false
  end
end
