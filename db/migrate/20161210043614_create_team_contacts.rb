class CreateTeamContacts < ActiveRecord::Migration
  def change
    create_table :team_contacts do |t|
      t.integer :team_id
      t.string :email

      t.timestamps null: false
    end
  end
end
