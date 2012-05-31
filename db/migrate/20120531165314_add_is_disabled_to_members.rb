class AddIsDisabledToMembers < ActiveRecord::Migration
  def change
    add_column :members, :is_disabled, :boolean
  end
end
