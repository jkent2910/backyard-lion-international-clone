class AthleteNote < ActiveRecord::Base
  belongs_to :team
  belongs_to :athlete_profile

  validates :note, :user_id, presence: true
end
