class AddActualCloseToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :actual_close, :date
  end
end
