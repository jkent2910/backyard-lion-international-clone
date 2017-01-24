class CreateBenefitRatings < ActiveRecord::Migration
  def change
    create_table :benefit_ratings do |t|
      t.integer :athlete_profile_id
      t.integer :benefit_id
      t.integer :benefit_rating

      t.timestamps null: false
    end

    add_index :benefit_ratings, :athlete_profile_id
  end
end
