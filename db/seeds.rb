# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

def create_athlete_users
  50.times do |n|
    email = Faker::Internet.email
    password = "password"
    password_confirmation = "password"
    user_type = 2
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    user = User.create!(email: email, first_name: first_name, last_name: last_name, password: password, password_confirmation: password_confirmation, user_type: user_type)
    create_athlete_profile(user.id)
    p "creating #{user.email}"
  end
end

def create_athlete_profile(user_id)
  athlete_profile = AthleteProfile.create!(user_id: user_id, gender: "male", first_language: "English", second_language: "German", birthday: Date.today,
                                           height_feet: 5, height_inches: 11, weight: 150, age: [18..32].sample, primary_citizenship: "United States", passport_ready: true, references_available: true, desired_salary: "Negotiable",
                                           athlete_experiences_attributes: [primary_position: "Quarterback", team_name: Faker::Team.creature, sport: "Football (American)", description: Faker::Lorem.paragraphs(1), level: "High School"])

  AthleteRecommendation.create!(athlete_profile_id: athlete_profile.id, giver_first_name: Faker::Name.first_name, giver_last_name: Faker::Name.last_name,
                                giver_relationship: "Friend", giver_position: "Football Coach", giver_athlete_profile_id: [1..50].sample  ,recommendation_text: Faker::Lorem.paragraphs(1))

  skill = AthleteSkill.create!(name: "Bench Press", units: "Pounds", athlete_profile_id: athlete_profile.id, result: "150")

  profile_id = AthleteProfile.all.pluck(:id).sample

  SkillEndorsement.create!(athlete_profile_id: athlete_profile.id, endorser_id: profile_id, athlete_skill_id: skill.id)

  AthleteCoach.create!(athlete_profile_id: athlete_profile.id, name: Faker::Name.name, title: "Head Coach", email: Faker::Internet.email, phone: Faker::PhoneNumber.phone_number, school: "University of Iowa")
end

def create_teams
  50.times do |n|
    team = Team.create!(sport: "Football (American)", country: "Czech Republic", town: "Ostrava", level: "Europe: 1st Division", gender: "male",
                 website: Faker::Internet.url, season: "Spring", team_name: Faker::Team.creature, other_benefits: Faker::Lorem.paragraph(2),
                 address: create_address)

    p "creating #{team.team_name}"

    WantedPosition.create(team_id: team.id, position_id: Position.all.pluck(:id).sample, priority: ["high", "medium", "low"].sample)
  end
end

def create_address
  street = Faker::Address.street_name
  city = Faker::Address.city
  state = Faker::Address.state
  zip = Faker::Address.zip_code

  street + " " +  city + "," + state + " " + zip
end

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
  User.create(email: "julie.kent@backyardlion.com", first_name: "Julie", last_name: "Kent", user_type: 1, password: "password", password_confirmation: "password")
  User.create(email: "devan.moylan@backyardlion.com", first_name: "Devan", last_name: "Moylan", user_type: 1, password: "password", password_confirmation: "password")
end

def create_team_contacts
  TeamContact.create(team_id: 1, email: "coachconfirm@gmail.com")
end

def create_team_users
  10.times do |n|
    email = Faker::Internet.email
    password = "password"
    password_confirmation = "password"
    user_type = 3
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    user = User.create!(email: email, first_name: first_name, last_name: last_name, password: password, password_confirmation: password_confirmation, user_type: user_type,
                        team_id: Team.all.pluck(:id).sample, team_validated: true)
    p "creating #{user.email}"
  end
end

create_athlete_users
create_positions
create_teams
create_admin_users
create_team_contacts
create_team_users