class AddUserIdToAthleteProfile < ActiveRecord::Migration
  def change
    add_column :athlete_profiles, :user_id, :integer
  end
end
