class AthleteVideo < ActiveRecord::Base
  belongs_to :athlete_profile

  validates :name, :url, presence: true

  has_many :athlete_video_comments
  has_many :users, :through => :athlete_video_comments
end
