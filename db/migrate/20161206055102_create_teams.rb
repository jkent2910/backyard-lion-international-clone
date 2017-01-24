class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :sport
      t.string :country
      t.string :town
      t.string :level
      t.integer :gender
      t.string :website
      t.string :season

      t.timestamps null: false
    end
  end
end
