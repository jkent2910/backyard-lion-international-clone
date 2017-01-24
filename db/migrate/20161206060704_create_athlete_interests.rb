class CreateAthleteInterests < ActiveRecord::Migration
  def change
    create_table :athlete_interests do |t|
      t.belongs_to :team, index: true
      t.belongs_to :athlete_profile, index: true

      t.timestamps null: false
    end
  end
end
