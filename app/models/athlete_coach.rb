class AthleteCoach < ActiveRecord::Base
  belongs_to :athlete_profile

  validates :name, :title, presence: true

end
