FactoryGirl.define do
  factory :athlete_notification do
    athlete_profile_id 1
    notification_type 1
    viewed false
    other_user_id 1
  end
end
