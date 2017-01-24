class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable

  enum user_type: { admin: 1, athlete: 2, team: 3 }

  validates :user_type, presence: true

  has_one :athlete_profile
  has_one :subscription

  has_many :saved_athletes
  has_many :athlete_profiles, :through => :saved_athletes

  after_create :generate_token, :if => :user_team?

  def mailboxer_email(object)
    email
  end

  def generate_token
    self.update_column(:token, SecureRandom.hex.to_s)
  end

  def user_team?
    self.team?
  end

  def saved_athlete?(athlete)
    athlete = SavedAthlete.find_by(user_id: self.id, athlete_profile_id: athlete.id)
    !athlete.nil?
  end

  def save_athlete(athlete)
    saved_athletes.create!(user_id: self, athlete_profile_id: athlete.id) unless saved_athlete?(athlete)
  end

  def unsave_athlete(athlete)
    athlete = saved_athletes.where("user_id = ? AND athlete_profile_id =?", self.id, athlete.id)
    athlete.destroy_all
  end

end
