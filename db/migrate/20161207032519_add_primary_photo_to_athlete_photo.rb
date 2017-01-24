class AddPrimaryPhotoToAthletePhoto < ActiveRecord::Migration
  def change
    add_column :athlete_photos, :primary_photo, :boolean, default: false, null: false
  end
end
