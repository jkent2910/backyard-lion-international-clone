class AddAgeToAthleteProfile < ActiveRecord::Migration
  def change
    add_column :athlete_profiles, :age, :integer
  end
end
