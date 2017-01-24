class Team < ActiveRecord::Base
  validates :sport, :country, presence: true
  enum gender: { female: 1, male: 2 }

  has_many :athlete_interests
  has_many :athlete_profiles, :through => :athlete_interests

  has_many :wanted_positions
  has_many :positions, -> { uniq }, :through => :wanted_positions
  accepts_nested_attributes_for :wanted_positions

  has_many :team_videos, dependent: :destroy
  accepts_nested_attributes_for :team_videos, reject_if: :all_blank, allow_destroy: true

  has_many :team_benefit_ratings, -> { joins(:benefit) }, dependent: :destroy
  has_many :benefits, through: :team_benefit_ratings
  accepts_nested_attributes_for :team_benefit_ratings

  has_many :athlete_notes, dependent: :destroy
  has_many :teams, :through => :athlete_notes

  has_many :team_photos, :dependent => :destroy

  has_many :team_notifications, dependent: :destroy

  has_attached_file :cover_photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.png"
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\z/

  geocoded_by :address
  after_validation :geocode

end
