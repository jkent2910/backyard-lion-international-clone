class CreateSkillEndorsements < ActiveRecord::Migration
  def change
    create_table :skill_endorsements do |t|
      t.integer :athlete_profile_id
      t.integer :endorser_id
      t.integer :skill_id

      t.timestamps null: false
    end
  end
end
