class SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    if request.env["HTTP_REFERER"].include? ("token")
      if params[:token].present?
        @user = User.find_by(token: params[:token])
        @user.update_attributes(team_validated: true)

        AdminMailer.new_team_owner(@user).deliver_later
      end
    end
    super
  end

end

