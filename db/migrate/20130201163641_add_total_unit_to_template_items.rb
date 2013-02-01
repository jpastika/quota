class AddTotalUnitToTemplateItems < ActiveRecord::Migration
  def change
    add_column :template_items, :total_unit, :string
  end
end
