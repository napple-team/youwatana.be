class ChangeTotalColumnTypeOnCounterTable < ActiveRecord::Migration[6.0]
  def change
    change_column :counts, :total, :decimal, precision: 30
  end
end
