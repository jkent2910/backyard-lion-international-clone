class CreateSavedAthletes < ActiveRecord::Migration
  def change
    create_table :saved_athletes do |t|
      t.integer :athlete_profile_id
      t.integer :user_id
      t.integer :rank_order

      t.timestamps null: false
    end
  end
end
