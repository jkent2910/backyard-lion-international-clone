class ChangeDateInExperience < ActiveRecord::Migration
  def change
    remove_column :athlete_experiences, :start_date
    remove_column :athlete_experiences, :end_date
    add_column :athlete_experiences, :start_date, :integer
    add_column :athlete_experiences, :end_date, :integer
  end
end
