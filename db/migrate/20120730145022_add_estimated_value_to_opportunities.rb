class AddEstimatedValueToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :estimated_value, :float
  end
end
