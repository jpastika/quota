class DropIsDisabledFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :is_disabled
  end
end
