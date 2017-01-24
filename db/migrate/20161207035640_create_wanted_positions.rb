class CreateWantedPositions < ActiveRecord::Migration
  def change
    create_table :wanted_positions do |t|
      t.belongs_to :team
      t.belongs_to :position

      t.integer :priority

      t.timestamps null: false
    end
  end
end
