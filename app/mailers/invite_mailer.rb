class InviteMailer < ApplicationMailer
  default from: 'devan@backyardlioninternational.com'

  def invite_email(first_name, last_name, high_school, email)
    @email = email
    @full_name = first_name + " " + last_name
    @high_school = high_school

    mail(:to => @email,
         :subject => "#{@full_name} is invited :-) - take a look inside (1 invitation!)")

  end

  def coach_invite_email(email, high_school, name)
    @email = email
    @high_school = high_school
    @name = name

    mail(:to => @email,
         :subject => "#{@name} is invited :-) - take a look inside (1 invitation!)")
  end

  def team_invite_email(team, email)
    @team_name = team.team_name
    @email = email

    mail(:to => @email,
         :subject => "#{@team_name} is invited :-) - take a look inside (1 invitation!)")
  end
end
