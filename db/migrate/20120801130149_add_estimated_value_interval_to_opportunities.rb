class AddEstimatedValueIntervalToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :estimated_value_interval, :string
  end
end
