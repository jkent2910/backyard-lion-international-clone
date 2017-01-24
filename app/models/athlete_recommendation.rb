class AthleteRecommendation < ActiveRecord::Base
  belongs_to :athlete_profile

  validates :recommendation_text, presence: true
end
