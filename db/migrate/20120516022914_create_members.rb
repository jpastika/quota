class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :account
      t.references :user

      t.timestamps
    end
    add_index :members, :account_id
    add_index :members, :user_id
    add_index :members, [:account_id, :user_id], unique: true
  end
end
