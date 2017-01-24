class CreateTeamBenefitRatings < ActiveRecord::Migration
  def change
    create_table :team_benefit_ratings do |t|
      t.integer :team_id
      t.integer :benefit_id
      t.integer :benefit_rating

      t.timestamps null: false
    end
    add_index :team_benefit_ratings, :team_id

  end
end
