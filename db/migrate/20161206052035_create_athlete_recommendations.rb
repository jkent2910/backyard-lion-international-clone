class CreateAthleteRecommendations < ActiveRecord::Migration
  def change
    create_table :athlete_recommendations do |t|
      t.integer :athlete_profile_id
      t.string :giver_first_name
      t.string :giver_last_name
      t.string :giver_relationship
      t.string :giver_position
      t.text :recommendation_text
      t.integer :giver_athlete_profile_id

      t.timestamps null: false
    end
  end
end
