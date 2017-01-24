class CreateAthleteCoaches < ActiveRecord::Migration
  def change
    create_table :athlete_coaches do |t|
      t.integer :athlete_profile_id
      t.string :name
      t.string :title
      t.string :email
      t.string :phone
      t.string :school

      t.timestamps null: false
    end
  end
end
