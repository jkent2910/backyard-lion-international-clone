class Position < ActiveRecord::Base
  has_many :wanted_positions
  has_many :teams, :through => :wanted_positions
end
