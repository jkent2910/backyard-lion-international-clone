class TeamVideo < ActiveRecord::Base
  belongs_to :team
  validates :name, :url, presence: true

  has_many :team_video_comments
  has_many :users, :through => :team_video_comments
end
