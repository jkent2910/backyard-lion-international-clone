class AddDefaultToViewed < ActiveRecord::Migration
  def change
    change_column :athlete_notifications, :viewed, :boolean, :default => false, :null => false
  end
end
