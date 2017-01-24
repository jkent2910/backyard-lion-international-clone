FactoryGirl.define do
  factory :athlete_note do
    athlete_profile_id 1
    team_id 1
    user_id 1
    note "MyText"
  end
end
