class WantedPosition < ActiveRecord::Base
  belongs_to :team
  belongs_to :position

  enum priority: { high: 1, medium: 2, low: 3 }
end
