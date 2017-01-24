class CreateAthleteNotes < ActiveRecord::Migration
  def change
    create_table :athlete_notes do |t|
      t.integer :athlete_profile_id
      t.integer :team_id
      t.integer :user_id
      t.text :note

      t.timestamps null: false
    end
  end
end
