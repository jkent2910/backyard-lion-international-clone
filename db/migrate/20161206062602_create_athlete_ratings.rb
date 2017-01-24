class CreateAthleteRatings < ActiveRecord::Migration
  def change
    create_table :athlete_ratings do |t|
      t.integer :rater_id
      t.integer :athlete_profile_id
      t.integer :rating

      t.timestamps null: false
    end
  end
end
