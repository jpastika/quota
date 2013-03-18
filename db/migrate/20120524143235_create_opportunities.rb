class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.string :name
      t.date :estimated_close
      t.string :milestone_key
      t.float :probability
      t.string :owner_key
      t.string :company_key

      t.timestamps
    end
  end
end
