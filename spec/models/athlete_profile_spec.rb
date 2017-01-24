require 'rails_helper'

RSpec.describe AthleteProfile, type: :model do
  context "validations" do
    [:first_name, :last_name, :gender, :first_language, :birthday, :height_feet, :height_inches, :weight, :primary_citizenship].each do |attr|
      it "validates presence of #{attr}" do
        expect(subject).to validate_presence_of(attr)
      end
    end
  end

  context "relationships" do
    it "belongs to a user" do
      expect(subject).to belong_to :user
    end
  end

  context "when an athlete profile is deleted" do
    before do
      @devan = FactoryGirl.create(:devan)
      @athlete_profile = FactoryGirl.create(:athlete_profile, user: @devan)
    end

    it "deletes the user" do
      expect { @athlete_profile.destroy }.to change { User.count }.by(-1)
    end
  end

end
