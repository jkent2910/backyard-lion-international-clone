class AdminMailer < ApplicationMailer
  default from: 'devan.moylan@backyardlion.com'

  def new_athlete_profile(athlete_profile)
    to_emails = "julie.kent@backyardlion.com, devan.moylan@backyardlion.com"

    @athlete = athlete_profile.decorate.full_name

    mail(:to => to_emails,
         :subject => "#{@athlete} has signed up as an athlete on BYL International")
  end

  def paid_subscription_notification(user, plan)
    to_emails = "julie.kent@backyardlion.com, devan.moylan@backyardlion.com"
    @plan = plan

    @user = user.decorate.full_name

    mail(:to => to_emails,
         :subject => "#{@user} has purchased a #{@plan} for BYL International")
  end

  def new_team_owner(user)
    to_emails = "julie.kent@backyardlion.com, devan.moylan@backyardlion.com"

    @user = user.decorate.full_name

    @team = Team.find(user.team_id).team_name

    mail(:to => to_emails,
         :subject => "#{@user} has been added as a team owner for BYL International")
  end

  def platinum_subscription_notification(user)
    to_emails = "julie.kent@backyardlion.com, devan.moylan@backyardlion.com"

    @user = user.decorate.full_name

    mail(:to => to_emails,
         :subject => "#{@user} wants to go platinum")
  end

  def daily_summary(team_validated, team_validated_no_id, user_count, athlete_profile_count, interest_count, aggregate_count)
    @user_count = user_count
    @athlete_profile_count = athlete_profile_count
    @interest_count = interest_count
    @athlete_profile_aggregate_count = aggregate_count
    @team_validated = team_validated
    @team_validated_no_id = team_validated_no_id

    to_emails = "julie.kent@backyardlion.com, devan.moylan@backyardlion.com"
    mail(:to => to_emails,
         :subject => "Daily summary for BYL International #{Date.today}")
  end

  def subscription_notification(email, full_name, team_name)
    @email = email
    @full_name = full_name
    @team_name = team_name

    mail(:to => @email,
         :subject => "1 Question + A Free Premium Subscription for #{@team_name}!" )
  end

  def email_athletes(email, full_name)
    @email = email
    @full_name = full_name

    mail(:to => @email,
         :subject => "Thank you for your continued support!")

  end


end