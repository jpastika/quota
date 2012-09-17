class AddIsDisabledToOpportunity < ActiveRecord::Migration
  def change
    add_column :opportunities, :is_disabled, :boolean, :default => false
  end
end
