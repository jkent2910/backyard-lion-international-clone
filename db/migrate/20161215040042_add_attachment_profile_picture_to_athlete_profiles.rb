class AddAttachmentProfilePictureToAthleteProfiles < ActiveRecord::Migration
  def self.up
    change_table :athlete_profiles do |t|
      t.attachment :profile_picture
    end
  end

  def self.down
    remove_attachment :athlete_profiles, :profile_picture
  end
end
