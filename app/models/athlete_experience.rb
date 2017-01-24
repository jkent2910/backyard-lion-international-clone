class AthleteExperience < ActiveRecord::Base
  belongs_to :athlete_profile

  validates :sport, :level, presence: true
end
