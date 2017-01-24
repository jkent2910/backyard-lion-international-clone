class AddTeamValidatedToUser < ActiveRecord::Migration
  def change
    add_column :users, :team_validated, :boolean, default: false, null: false
  end
end
