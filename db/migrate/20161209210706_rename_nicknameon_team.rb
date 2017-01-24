class RenameNicknameonTeam < ActiveRecord::Migration
  def change
    rename_column :teams, :nickname, :team_name
  end
end
