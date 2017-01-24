class CreateAthleteProfiles < ActiveRecord::Migration
  def change
    create_table :athlete_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.string :first_language
      t.string :second_language
      t.string :third_language
      t.date :birthday
      t.integer :height_feet
      t.integer :height_inches
      t.integer :weight
      t.string :primary_citizenship
      t.string :secondary_citizenship

      t.timestamps null: false
    end
  end
end
