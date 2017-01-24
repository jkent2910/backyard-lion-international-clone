desc "Reset team_view_count"
task reset_team_view_count: :environment do

  # Get all non-premium users
  User.where(paid_subscription: false).each do |u|
    u.update_attributes(team_view_count: 0)
  end
end

desc "Reset team_view_count"
task reset_athlete_view_count: :environment do

  # Get all non-premium users
  User.where(paid_subscription: false).each do |u|
    u.update_attributes(athlete_view_count: 0)
  end
end

desc "Reset message_count"
task reset_message_count: :environment do
  # Get all non-premium users
  User.where(paid_subscription: false).each do |u|
    u.update_attributes(message_count: 0)
  end
end

desc "Reset express_interest"
task reset_express_interest_count: :environment do
  # Get all non-premium users
  User.where(paid_subscription: false).each do |u|
    # Get athlete_profile and reset express_interest_count
    unless u.athlete_profile.nil? || !u.athlete_profile.valid?
      u.athlete_profile.update_attributes(express_interest_count: 0)
    end
  end
end

desc "Reset saved_athletes"
task reset_saved_athlete_count: :environment do
  # Get all non-premium users
  User.where(paid_subscription: false).each do |u|
    u.update_attributes(saved_athletes_count: 0)
  end
end

desc "Daily summary to BYL Admin"
task daily_user_summary: :environment do
  user_count = User.where(created_at: (Time.now - 24.hours)..Time.now).count
  athlete_profile_aggregate_count = AthleteProfile.count
  athlete_profile_count = AthleteProfile.where(created_at: (Time.now - 24.hours)..Time.now).count
  interest_count = AthleteInterest.where(created_at: (Time.now - 24.hours)..Time.now).count
  team_validated = User.where(team_validated: true).count
  team_validated_no_id = User.where("team_id = ? AND team_validated = ?", nil, true).count

  AdminMailer.daily_summary(team_validated, team_validated_no_id, user_count, athlete_profile_count, interest_count, athlete_profile_aggregate_count).deliver_later
end