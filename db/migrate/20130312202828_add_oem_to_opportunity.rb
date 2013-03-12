class AddOemToOpportunity < ActiveRecord::Migration
  def change
    add_column :opportunities, :oem_key, :string
    add_column :opportunities, :oem_rep_key, :string
  end
end
