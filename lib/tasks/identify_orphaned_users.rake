namespace :backyard_lion_international do

  desc "Delete athlete_profiles and users who are no longer active"
  task identify_orphaned_users: :environment do

    AthleteProfile.where.not(user_id: nil).each do |a|
      if a.user.nil?
        puts "#{a.id} does not appear to have a user"
      end
    end
  end
end