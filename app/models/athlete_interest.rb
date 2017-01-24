class AthleteInterest < ActiveRecord::Base
  belongs_to :team
  belongs_to :athlete_profile
end
