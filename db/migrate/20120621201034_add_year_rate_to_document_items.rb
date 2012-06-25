class AddYearRateToDocumentItems < ActiveRecord::Migration
  def change
    add_column :document_items, :year_rate, :float
  end
end
