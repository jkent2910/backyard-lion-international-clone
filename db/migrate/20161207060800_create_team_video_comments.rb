class CreateTeamVideoComments < ActiveRecord::Migration
  def change
    create_table :team_video_comments do |t|
      t.text :body
      t.belongs_to :team_video
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
