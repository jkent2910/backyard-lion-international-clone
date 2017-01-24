namespace :backyard_lion_international do

  desc "Grabs team owners and sets their subscription"
  task print_team_owners: :environment do
    users = User.where(team_validated: true)

    users.each do |u|
      email = u.email
      full_name = u.first_name + " " + u.last_name
      team = Team.find(u.team_id).team_name
      puts "#{full_name} with email #{email} owns the team #{team}"
    end
  end

  desc "Updates paid_subscription for team users"
  task update_subscription_level: :environment do
    users = User.where(team_validated: true)

    users.each do |u|
      u.update_attributes(paid_subscription: true)
      s = Subscription.create(user_id: u.id, subscription_level: 4)
      puts "subscription created #{s.id} for #{u.email}"
    end
  end

  desc "Sends e-mail to team owners"
  task send_team_owner_email: :environment do

    users = User.where(team_validated: true)

    users.each do |u|
      email = u.email
      full_name = u.first_name + " " + u.last_name
      team = Team.find(u.team_id).team_name
      AdminMailer.subscription_notification(email, full_name, team).deliver_later
      puts "send e-mail to #{team}"
    end
  end
end