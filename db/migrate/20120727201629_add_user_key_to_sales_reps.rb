class AddUserKeyToSalesReps < ActiveRecord::Migration
  def change
    add_column :users, :remember_token, :string
    add_column :sales_reps, :user_key, :string
    remove_column :sales_reps, :member_key
  end
end
