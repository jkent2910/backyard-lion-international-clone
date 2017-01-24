class AddAdditionalInfoToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :additional_info, :text
  end
end
