namespace :backyard_lion_international do

  desc "initial rake tasks"
  task initial_rake_tasks: :environment do



    def create_positions
      Position.destroy_all

      basketball_positions = ["Head Coach (Basketball)", "Assistant Coach (Basketball)", "Point Guard", "Shooting Guard", "Small Forward", "Forward", "Center"]
      football_positions = ["Head Coach (Football - American)", "Assistant Coach (Football - American)", "Offensive Coordinator", "Defensive Coordinator", "Quarterbacks Coach",
                            "Other Coach", "Center", "Offensive Guard", "Offensive Tackle", "Offensive Tackle", "Quarterback", "Running Back", "Wide Receiver", "Tight End", "Defensive Tackle",
                            "Defensive End", "Middle Linebacker", "Outside Linebacker", "Cornerback", "Safety", "Nickleback", "Dimeback", "Kicker", "Holder", "Long snapper", "Punter", "Kick/Punt Reterner", "Other Special Teams"]

      basketball_positions.each { |position| Position.find_or_create_by(sport: "Basketball", name: position) }
      football_positions.each { |position| Position.find_or_create_by(sport: "Football (American)", name: position) }
    end

    def create_admin_users
      User.create(email: "julie.kent@backyardlioninternational.com", first_name: "Julie", last_name: "Kent", user_type: 1, password: "password", password_confirmation: "password")
      User.create(email: "devan.moylan@backyardlioninternational.com", first_name: "Devan", last_name: "Moylan", user_type: 1, password: "password", password_confirmation: "password")
    end

    def create_benefits
      benefits = [
          "Car paid",
          "Accommodation paid",
          "Return flight paid",
          "Daily meal paid",
          "Insurance paid",
          "Gym paid",
          "Phone paid"
      ]

      Benefit.destroy_all
      benefits.each { |b| Benefit.find_or_create_by name: b }
    end



    create_positions
    create_admin_users
    create_benefits


  end
end
