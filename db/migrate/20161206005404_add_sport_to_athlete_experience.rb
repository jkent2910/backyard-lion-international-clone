class AddSportToAthleteExperience < ActiveRecord::Migration
  def change
    add_column :athlete_experiences, :sport, :string
  end
end
