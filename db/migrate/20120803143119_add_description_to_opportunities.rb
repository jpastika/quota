class AddDescriptionToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :description, :text
  end
end
