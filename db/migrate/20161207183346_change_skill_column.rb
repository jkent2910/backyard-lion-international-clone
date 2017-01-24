class ChangeSkillColumn < ActiveRecord::Migration
  def change
    rename_column :skill_endorsements, :skill_id, :athlete_skill_id
  end
end
