class SetBooleanDefaultsOnQuote < ActiveRecord::Migration
  def change
    change_column :quotes, :is_draft, :boolean, :default => false
  end
end
