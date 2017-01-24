class AddTeamViewCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :team_view_count, :integer, default: 0
  end
end
