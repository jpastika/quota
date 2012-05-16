class AddPublicKeyToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :public_key, :string
  end
end
