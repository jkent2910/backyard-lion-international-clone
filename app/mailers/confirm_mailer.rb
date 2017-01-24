class ConfirmMailer < ActionMailer::Base

  default from: 'devan.moylan@backyardlioninternational.com'

  def auto_confirm_mailer(token, user_email, user)
    @token = token
    @email = user_email
    @user = user

    to_emails = @email

    mail(:to => to_emails,
         :subject => "Please confirm your Backyard Lion International account")
  end

  def manual_confirm_mailer(user_email, team_website, team_name)
    @user_email = user_email
    @team_website = team_website
    @team_name = team_name

    to_emails = "julie.kent@backyardlion.com, devan.moylan@backyardlion.com"

    mail(:to => to_emails,
         :subject => "A New Coach Has Requested To Join Backyard Lion International But Needs Verificiation")


  end
end



