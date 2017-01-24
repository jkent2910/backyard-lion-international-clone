class CreateTeamNotifications < ActiveRecord::Migration
  def change
    create_table :team_notifications do |t|
      t.integer :team_id
      t.integer :notification_type
      t.boolean :viewed
      t.integer :other_user_id

      t.timestamps null: false
    end
  end
end
