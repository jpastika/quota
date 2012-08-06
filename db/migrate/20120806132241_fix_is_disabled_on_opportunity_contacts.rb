class FixIsDisabledOnOpportunityContacts < ActiveRecord::Migration
  def change
    remove_column :opportunity_contacts, :boolean
    remove_column :opportunity_contacts, :is_disabled
    
    add_column :opportunity_contacts, :is_disabled, :boolean, :default => false
  end
end
