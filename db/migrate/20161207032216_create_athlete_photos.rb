class CreateAthletePhotos < ActiveRecord::Migration
  def change
    create_table :athlete_photos do |t|
      t.attachment :image
      t.integer :athlete_profile_id
      t.timestamps null: false
    end
  end
end
