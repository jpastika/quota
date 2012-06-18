class CreateSalesReps < ActiveRecord::Migration
  def change
    create_table :sales_reps do |t|
      t.string :name
      t.string :pub_key
      t.string :email
      t.string :account_key
      t.string :member_key
      t.boolean :is_disabled, :default => false

      t.timestamps
    end
    
    add_index :sales_reps, :pub_key
    add_index :sales_reps, :member_key
    add_index :sales_reps, :account_key
  end
end
