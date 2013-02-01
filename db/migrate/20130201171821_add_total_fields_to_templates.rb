class AddTotalFieldsToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :total_purchase, :float, :default => 0
    add_column :templates, :total_hourly, :float, :default => 0
    add_column :templates, :total_daily, :float, :default => 0
    add_column :templates, :total_weekly, :float, :default => 0
    add_column :templates, :total_monthly, :float, :default => 0
    add_column :templates, :total_quarterly, :float, :default => 0
    add_column :templates, :total_yearly, :float, :default => 0
  end
end
