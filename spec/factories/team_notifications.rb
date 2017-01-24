FactoryGirl.define do
  factory :team_notification do
    team_id 1
    notification_type 1
    viewed false
    other_user_id ""
  end
end
