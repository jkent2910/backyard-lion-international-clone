class NotificationMailer < ApplicationMailer
  default from: 'devan@backyardlioninternational.com'

  def profile_view_notification(athlete_profile)
    @email = User.find(athlete_profile.user_id).email
    @athlete_name = User.find(athlete_profile.user_id).decorate.full_name

    mail(:to => @email,
         :subject => "Someone has been looking at your profile!")

  end

  def skill_endorsement_notification(athlete_profile)
    @email = User.find(athlete_profile.user_id).email
    @athlete_name = User.find(athlete_profile.user_id).decorate.full_name

    mail(:to => @email,
         :subject => "Someone has endorsed you!")
  end

  def rating_notification(athlete_profile)
    @email = User.find(athlete_profile.user_id).email
    @athlete_name = User.find(athlete_profile.user_id).decorate.full_name

    mail(:to => @email,
         :subject => "Someone has rated you!")
  end

  def recommendation_notification(athlete_profile_id)
    athlete = AthleteProfile.find(athlete_profile_id)

    @email = User.find(athlete.user_id).email
    @athlete_name = athlete.decorate.full_name

    mail(:to => @email,
         :subject => "Someone has recommended you!")
  end

  def video_comment_notification(athlete_profile)
    @email = User.find(athlete_profile.user_id).email
    @athlete_name = User.find(athlete_profile.user_id).decorate.full_name

    mail(:to => @email,
         :subject => "Someone has commented on your video!")
  end

  def express_interest_team(email, team_id)
    @email = email
    @team_name = Team.find(team_id).team_name

    mail(:to => @email,
           :subject => "Someone has expressed interest in #{@team_name}!")
  end

  def team_view(email, team_id)
    @team_name = Team.find(team_id).team_name
      @email = email

      mail(:to => @email,
           :subject => "Hi, #{@team_name} - We Have Some News for You >>")

  end
end
