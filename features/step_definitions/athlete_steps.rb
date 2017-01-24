Then(/^there should be a athlete with name "([^"]*)"$/) do |first_name|
  athlete = AthleteProfile.find_by(first_name: first_name)
  expect(athlete).to_not be_nil
end
