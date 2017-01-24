class AddRankOrderToAthleteInterest < ActiveRecord::Migration
  def change
    add_column :athlete_interests, :rank_order, :integer
  end
end
