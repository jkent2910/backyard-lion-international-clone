class AthleteProfile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  has_many :athlete_experiences, dependent: :destroy
  accepts_nested_attributes_for :athlete_experiences, reject_if: :all_blank, allow_destroy: true

  has_many :benefit_ratings, -> { joins(:benefit) }, dependent: :destroy
  has_many :benefits, through: :benefit_ratings
  accepts_nested_attributes_for :benefit_ratings

  has_many :athlete_videos, dependent: :destroy
  accepts_nested_attributes_for :athlete_videos, reject_if: :all_blank, allow_destroy: true

  has_many :athlete_skills, dependent: :destroy
  accepts_nested_attributes_for :athlete_skills, reject_if: :all_blank, allow_destroy: true

  has_many :athlete_coaches
  accepts_nested_attributes_for :athlete_coaches, reject_if: :all_blank, allow_destroy: true

  has_many :athlete_recommendations, dependent: :destroy

  has_many :athlete_interests, dependent: :destroy
  has_many :teams, :through => :athlete_interests

  has_many :athlete_ratings, dependent: :destroy
  has_many :athlete_photos, :dependent => :destroy

  has_many :saved_athletes, dependent: :destroy
  has_many :users, :through => :saved_athletes

  has_many :athlete_notes, dependent: :destroy
  has_many :teams, :through => :athlete_notes

  has_many :athlete_notifications, dependent: :destroy

  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\z/

  enum gender: { female: 1, male: 2 }

  validates :gender, :first_language, :birthday, :height_feet, :height_inches, :weight, :primary_citizenship, presence: true

  validate :require_one_experience

  def require_one_experience
    errors.add(:athlete_experience, "You must provide at least one experience") if athlete_experiences.size < 1
  end

  def remove_interest(team)
    AthleteInterest.find_by(team_id: team, athlete_profile_id: self.id).destroy
  end

  def express_interest(team, user_id)
    athlete_interests.create!(team_id: team, athlete_profile_id: self) unless expressed_interest?(team)

    if TeamContact.where(team_id: team).exists?
      contact = TeamContact.where(team_id: team)
      contact.each do |c|
        NotificationMailer.express_interest_team(c.email, c.team_id).deliver_later
      end
    end

    # Create notification for team
    unless TeamNotification.where('team_id = ? AND other_user_id = ? AND notification_type = ?', team, user_id, 2).any?
      TeamNotification.create!(team_id: team, notification_type: "athlete_interest", other_user_id: user_id)
    end

  end

  def expressed_interest?(team)
    !AthleteInterest.find_by(team_id: team, athlete_profile_id: self.id).nil?
  end

  def endorsed_skill?(skill, endorser)
    !SkillEndorsement.find_by(endorser_id: endorser, athlete_skill_id: skill).nil?
  end

  def remove_skill_endorsement(skill, endorser)
    SkillEndorsement.find_by(endorser_id: endorser.id, athlete_skill_id: skill.id).destroy
  end

  def endorse_skill(skill, endorser)
    SkillEndorsement.create!(athlete_profile_id: self.id, athlete_skill_id: skill.id, endorser_id: endorser.id) unless endorsed_skill?(skill, endorser)
  end
end