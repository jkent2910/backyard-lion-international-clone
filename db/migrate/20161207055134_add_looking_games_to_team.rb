class AddLookingGamesToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :looking_games, :boolean
  end
end
