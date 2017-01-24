Given(/^I am a "([^"]*)" user$/) do |user_type|
  @user = FactoryGirl.create(:user, user_type: user_type)
end

Given(/^I am a "([^"]*)" user named "([^"]*)"$/) do |user_type, name|
  @user = FactoryGirl.create(:user, user_type: user_type)
  athlete = FactoryGirl.create(:athlete_profile, user_id: @user.id, first_name: name)
end