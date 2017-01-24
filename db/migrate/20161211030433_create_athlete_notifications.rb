class CreateAthleteNotifications < ActiveRecord::Migration
  def change
    create_table :athlete_notifications do |t|
      t.integer :athlete_profile_id
      t.integer :notification_type
      t.boolean :viewed
      t.integer :other_user_id

      t.timestamps null: false
    end
  end
end
