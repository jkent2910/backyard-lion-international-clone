class TeamContact < ActiveRecord::Base

  validates_presence_of :team_id, :email
end
