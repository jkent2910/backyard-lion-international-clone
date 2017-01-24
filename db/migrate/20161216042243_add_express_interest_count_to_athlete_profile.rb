class AddExpressInterestCountToAthleteProfile < ActiveRecord::Migration
  def change
    add_column :athlete_profiles, :express_interest_count, :integer, default: 0
    add_column :users, :saved_athletes_count, :integer, default: 0
  end
end
