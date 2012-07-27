class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :name
      t.string :pub_key
      t.string :account_key
      t.float :probability
      t.boolean :is_disabled

      t.timestamps
    end
    
    add_index :milestones, :pub_key
    add_index :milestones, :account_key
  end
end
