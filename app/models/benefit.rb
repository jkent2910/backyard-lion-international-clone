class Benefit < ActiveRecord::Base
  validates_presence_of :name
  has_many :benefit_ratings
  has_many :team_benefit_ratings
end
