class AthleteRating < ActiveRecord::Base
  belongs_to :athlete_profile
  validates :rater_id, :rating, :athlete_profile_id, presence: true
end
