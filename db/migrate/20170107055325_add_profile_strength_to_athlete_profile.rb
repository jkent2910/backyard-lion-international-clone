class AddProfileStrengthToAthleteProfile < ActiveRecord::Migration
  def change
    add_column :athlete_profiles, :profile_strength, :decimal
  end
end
