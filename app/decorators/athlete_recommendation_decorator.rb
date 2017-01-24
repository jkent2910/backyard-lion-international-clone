class AthleteRecommendationDecorator < Draper::Decorator
  delegate_all

  def full_name
    object.giver_first_name + " " + object.giver_last_name
  end
end