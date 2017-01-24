class CreateTeamPhotos < ActiveRecord::Migration
  def change
    create_table :team_photos do |t|
      t.attachment :image
      t.integer :team_id
      t.boolean :primary_photo, default: false, null: false
      t.timestamps null: false
    end
  end
end
