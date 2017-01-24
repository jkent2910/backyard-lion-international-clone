class AddAttachmentCoverPhotoToTeams < ActiveRecord::Migration
  def self.up
    change_table :teams do |t|
      t.attachment :cover_photo
    end
  end

  def self.down
    remove_attachment :teams, :cover_photo
  end
end
