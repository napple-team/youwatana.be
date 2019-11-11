class CreateCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :counts do |t|
      t.integer :total, default: 0, null: false
      t.timestamps
    end
  end
end
