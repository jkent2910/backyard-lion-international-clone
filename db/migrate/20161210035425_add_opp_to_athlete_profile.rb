class AddOppToAthleteProfile < ActiveRecord::Migration
  def change
    add_column :athlete_profiles, :player_interest, :boolean, default: false, null: false
    add_column :athlete_profiles, :coach_interest, :boolean, default: false, null: false
  end
end
