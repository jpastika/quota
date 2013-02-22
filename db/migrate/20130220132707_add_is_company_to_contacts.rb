class AddIsCompanyToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :is_company, :boolean, :default => false
  end
end
