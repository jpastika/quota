class AddIndexToAccountsOnPubKey < ActiveRecord::Migration
  def change
    add_index :accounts, :pub_key, unique: true
  end
end
