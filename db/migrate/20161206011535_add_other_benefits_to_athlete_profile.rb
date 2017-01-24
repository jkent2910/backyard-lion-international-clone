class AddOtherBenefitsToAthleteProfile < ActiveRecord::Migration
  def change
    add_column :athlete_profiles, :other_benefits, :text
  end
end
