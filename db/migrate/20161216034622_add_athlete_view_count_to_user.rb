class AddAthleteViewCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :athlete_view_count, :integer, default: 0
  end
end
