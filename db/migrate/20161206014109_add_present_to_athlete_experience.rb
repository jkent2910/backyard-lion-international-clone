class AddPresentToAthleteExperience < ActiveRecord::Migration
  def change
    add_column :athlete_experiences, :present, :boolean
  end
end
