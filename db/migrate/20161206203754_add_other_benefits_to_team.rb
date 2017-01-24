class AddOtherBenefitsToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :other_benefits, :text
  end
end
