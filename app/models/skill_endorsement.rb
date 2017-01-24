class SkillEndorsement < ActiveRecord::Base
  belongs_to :athlete_skill

  validates :athlete_profile_id, :endorser_id, :athlete_skill_id, presence: true
end
