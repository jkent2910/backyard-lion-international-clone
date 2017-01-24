class NewUserMailer < ActionMailer::Base

  default from: 'devan.moylan@backyardlioninternational.com'

  def welcome_email(athlete_profile)
    @athlete_email = athlete_profile.user.email
    @athlete_first_name = athlete_profile.user.first_name
    @athlete_sport = athlete_profile.athlete_experiences.first.sport rescue nil 

    mail(:to => @athlete_email,
         :subject => "You're in :) | Plus, a quick question....",
         :from => "devan@backyardlioninternational.com")
  end



end