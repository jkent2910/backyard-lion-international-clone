namespace :backyard_lion_international do

  desc "Send invites to team contacts"
  task send_team_invites: :environment do

    TeamContact.all.each do |contact|
      unless contact.team_id.nil? || contact.email.nil?
        team = Team.find(contact.team_id)
        email = contact.email
        InviteMailer.team_invite_email(team, email).deliver_later
        puts "sending invite to #{email}"
      end
    end
  end
end