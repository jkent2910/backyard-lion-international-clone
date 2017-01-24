class AddDesiredSalaryToAthleteProfile < ActiveRecord::Migration
  def change
    add_column :athlete_profiles, :desired_salary, :string
  end
end
