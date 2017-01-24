class CreateTeamVideos < ActiveRecord::Migration
  def change
    create_table :team_videos do |t|
      t.string :name
      t.string :url
      t.text :description
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
