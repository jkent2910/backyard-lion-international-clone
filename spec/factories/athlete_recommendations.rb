FactoryGirl.define do
  factory :athlete_recommendation do
    athlete_profile_id 1
    giver_first_name "MyString"
    giver_last_name "MyString"
    giver_relationship "MyString"
    giver_position "MyString"
    recommendation_text "MyText"
    giver_athlete_profile_id 1
  end
end
