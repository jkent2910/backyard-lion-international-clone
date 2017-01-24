class LookingForColumnsToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :looking_for_players, :boolean, default: false, null: false
    add_column :teams, :looking_for_coaches, :boolean, default: false, null: false
  end
end
