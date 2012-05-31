class AddDefaultToIsDisabledOnMembers < ActiveRecord::Migration
  def change
    change_column :members, :is_disabled, :boolean, :default => false
  end
end
