class AthleteNotification < ActiveRecord::Base
  belongs_to :athlete_profile

  enum notification_type: { team_profile_view: 1, athlete_profile_view: 2, skill_endorsement: 3, recommendation: 4, rating: 5, video_comment: 6 }

  validates :athlete_profile_id, :notification_type, presence: true

end