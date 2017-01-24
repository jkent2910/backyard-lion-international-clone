class AddSalaryToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :salary, :string
  end
end
