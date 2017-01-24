class CreateAthleteSkills < ActiveRecord::Migration
  def change
    create_table :athlete_skills do |t|
      t.string :name
      t.string :units
      t.integer :athlete_profile_id
      t.string :result

      t.timestamps null: false
    end
  end
end
