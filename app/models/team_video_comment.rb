class TeamVideoComment < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :team_video
  belongs_to :user
end
