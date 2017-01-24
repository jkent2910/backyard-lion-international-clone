class CreateAthleteVideos < ActiveRecord::Migration
  def change
    create_table :athlete_videos do |t|
      t.string :name
      t.string :url
      t.text :description
      t.integer :athlete_profile_id

      t.timestamps null: false
    end
  end
end
