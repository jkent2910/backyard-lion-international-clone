class AthleteSkill < ActiveRecord::Base
  belongs_to :athlete_profile
  validates :name, :units, :result, presence: true

  has_many :skill_endorsements, dependent: :destroy
end
