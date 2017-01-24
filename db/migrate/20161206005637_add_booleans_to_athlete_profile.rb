class AddBooleansToAthleteProfile < ActiveRecord::Migration
  def change
    add_column :athlete_profiles, :passport_ready, :boolean, :default => false, :null => false
    add_column :athlete_profiles, :references_available, :boolean, :default => false, :null => false
    add_column :athlete_profiles, :agent_used, :boolean, :default => false, :null => false
    add_column :athlete_profiles, :actively_looking, :boolean, :default => false, :null => false
    add_column :athlete_profiles, :coaching_experience, :boolean, :default => false, :null => false
  end
end
