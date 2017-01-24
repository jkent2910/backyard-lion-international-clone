class AddResumeToAthleteProfile < ActiveRecord::Migration
  def change
    add_column :athlete_profiles, :resume, :text
  end
end
