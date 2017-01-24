class Subscription < ActiveRecord::Base
  belongs_to :user

  enum subscription_level: { silver_monthly: 1, gold_monthly: 2, platinum_monthly: 3,
                             silver_annually: 4, gold_annually: 5, platinum_annually: 6 }
end
