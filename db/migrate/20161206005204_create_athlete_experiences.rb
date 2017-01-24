class CreateAthleteExperiences < ActiveRecord::Migration
  def change
    create_table :athlete_experiences do |t|
      t.string :primary_position
      t.string :secondary_position
      t.string :team_name
      t.date :start_date
      t.date :end_date
      t.text :description
      t.integer :athlete_profile_id
      t.string :level

      t.timestamps null: false
    end
  end
end
