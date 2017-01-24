class AthleteProfileDecorator < Draper::Decorator
  delegate_all

  def full_name
    User.find(object.user_id).first_name rescue nil + " " + User.find(object.user_id).last_name rescue nil
  end

  def average_rating
    if object.athlete_ratings.empty?
      "N/A"
    else
      average_rating = object.athlete_ratings.average(:rating).to_f
      if average_rating >= 0.to_f && average_rating <= 0.99
        "C-"
      elsif average_rating >= 1.to_f && average_rating <= 1.49
        "C"
      elsif average_rating >= 1.50 && average_rating <= 1.99
        "C+"
      elsif average_rating >= 2.to_f && average_rating <= 2.49
        "B-"
      elsif average_rating >= 2.50 && average_rating <= 2.99
        "B+"
      elsif average_rating >= 3.to_f && average_rating <= 3.49
        "B+"
      elsif average_rating >= 3.50 && average_rating <= 3.99
        "A-"
      elsif average_rating >= 4.to_f && average_rating <= 4.50
        "A"
      elsif average_rating >= 4.51 && average_rating <= 4.99
        "A+"
      elsif average_rating >= 5.0
        "A+"
      end
    end
  end

end