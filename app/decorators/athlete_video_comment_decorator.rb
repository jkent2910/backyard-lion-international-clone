class AthleteVideoCommentDecorator < Draper::Decorator
  delegate_all

  def commenter_name
    User.find(object.user_id).first_name + " " + User.find(object.user_id).last_name
  end
end