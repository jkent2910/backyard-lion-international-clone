class SavedAthlete < ActiveRecord::Base
  belongs_to :user
  belongs_to :athlete_profile

  default_scope { order("rank_order ASC") }
end
