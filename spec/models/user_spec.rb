require 'rails_helper'

RSpec.describe User, type: :model do
  it "has an athlete_profile" do
    expect(subject).to have_one(:athlete_profile)
    end
end
