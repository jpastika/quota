class ChangePublicKeyToPubKeyOnAccounts < ActiveRecord::Migration
  def change
    rename_column :accounts, :public_key, :pub_key
  end
end
