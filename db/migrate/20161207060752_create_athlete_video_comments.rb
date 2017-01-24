class CreateAthleteVideoComments < ActiveRecord::Migration
  def change
    create_table :athlete_video_comments do |t|
      t.text :body
      t.belongs_to :athlete_video
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
