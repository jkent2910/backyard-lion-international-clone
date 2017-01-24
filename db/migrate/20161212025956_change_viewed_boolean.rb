class ChangeViewedBoolean < ActiveRecord::Migration
  def change
    change_column :team_notifications, :viewed, :boolean, :default => false, :null => false
  end
end
