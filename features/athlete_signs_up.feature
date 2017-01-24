Feature: Athlete signs up
  As an athlete
  I want to sign up
  So I can create an athlete profile

  Scenario: Athlete signs up
    Given I am on the landing page
    And I follow "Sign up"
    And I fill in "user_email" with "athlete@gmail.com"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I choose "user_user_type_athlete"
    And I press "Sign up"
    Then I should be on the new athlete page

  Scenario: Athlete creates a profile
    Given I am on the landing page
    And I follow "Sign up"
    And I fill in "user_email" with "athlete@gmail.com"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I choose "user_user_type_athlete"
    And I press "Sign up"
    And I fill in "First name" with "Julie"
    And I fill in "Last name" with "Kent"
    And I choose "athlete_profile_gender_female"
    And I select "English" from "First language"
    And I select "United States" from "Primary citizenship"
    And I select "5" from "athlete_profile_height_feet"
    And I select "6" from "athlete_profile_height_inches"
    And I select "125" from "athlete_profile_weight"
    And I press "Create Athlete profile"
    Then I should be on the athlete page for "Julie"
    And there should be a athlete with name "Julie"

  Scenario: Athlete signs up but hasn't created a profile
    Given I am a "athlete" user
    And I sign in
    Then I should be on the new athlete page

  Scenario: Vendor signs in with a profile
    Given I am a "athlete" user named "Julie"
    And I sign in
    Then I should be on the athlete page for "Julie"