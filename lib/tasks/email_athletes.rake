namespace :backyard_lion_international do

  desc "Sends e-mail to athletes"
  task send_athlete_email: :environment do

    users = User.where(user_type: 2)

    users.each do |u|
      email = u.email
      full_name = u.first_name + " " + u.last_name
      AdminMailer.email_athletes(email, full_name).deliver_later
      puts "send e-mail to #{full_name}"
    end
  end
end