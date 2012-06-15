class ChangeCoampnyPhoneToCompanyPhoneOnQuotes < ActiveRecord::Migration
  def change
    rename_column :quotes, :compoany_phone, :company_phone
  end
end
