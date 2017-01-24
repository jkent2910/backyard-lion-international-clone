class TeamBenefitRating < ActiveRecord::Base
  belongs_to :team
  belongs_to :benefit

  enum benefit_rating: { yes: 1, preferred: 2, no: 3 }

end
