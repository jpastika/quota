class CreateOemContacts < ActiveRecord::Migration
  def change
    create_table :oem_reps do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :pub_key
      t.string :oem_key
      t.string :account_key
      t.boolean :is_disabled

      t.timestamps
    end
    
    add_index :oem_reps, :pub_key
    add_index :oem_reps, :account_key
    add_index :oem_reps, :oem_key
  end
end
