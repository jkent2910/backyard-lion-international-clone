class AddAthleteHeightToAthleteProfile < ActiveRecord::Migration
  def change
    add_column :athlete_profiles, :athlete_height, :float
  end
end
