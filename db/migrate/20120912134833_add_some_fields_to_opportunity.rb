class AddSomeFieldsToOpportunity < ActiveRecord::Migration
  def change
    add_column :opportunities, :is_cancelled, :boolean, :default => false
    add_column :opportunities, :is_sold, :boolean, :default => false
    add_column :opportunities, :actual_cancel, :date
  end
end
