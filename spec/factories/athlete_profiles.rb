FactoryGirl.define do
  factory :athlete_profile do
    first_name "Julie"
    last_name "Kent"
    gender "female"
    first_language "English"
    birthday Date.today
    height_feet 5
    height_inches 7
    weight 130
    primary_citizenship "United States"

    association :user, factory: :user
  end
end