class UsersController < ApplicationController

  before_action :set_user, only: [:update, :new_team, :dashboard, :view_notifications]
  before_filter :ensure_user_rights, only: [:dashboard, :saved_athletes, :view_notifications]
  before_filter :ensure_team, only: [:dashboard, :saved_athletes]
  skip_before_action :verify_authenticity_token, only: [:save_athlete, :unsave_athlete]
  before_action :check_saved_athlete_count, only: [:save_athlete, :unsave_athlete]


  def index
    @users = User.order('created_at DESC').paginate(page: params[:page], per_page: 30)
  end

  def update
    if @user.update(user_params)
      if params[:team_website_url].present?
        @user.team_validated = false
        token = @user.token

        #This handles the "Other" selection from the team_name dropdown
        if params[:user][:team_id] == "Other"
          team_id = nil
        else
          team_id = params[:user][:team_id]
        end

        if !TeamContact.find_by(team_id: team_id, email: @user.email).nil?
          ConfirmMailer.auto_confirm_mailer(token, @user.email, @user.to_param).deliver_later
          sign_out @user
          redirect_to root_path, notice: "Great, we've sent you an e-mail to confirm your account"
        else

          #This handles the "Other" selection from the team_name dropdown
          if params[:user][:team_id] == "Other"
            team_name = "Other"
          else
            team_name = Team.find(params[:user][:team_id]).team_name
          end

          ConfirmMailer.manual_confirm_mailer(@user.email, params[:team_website_url], team_name).deliver_later
          sign_out @user
          redirect_to root_path, notice: "Thanks!  We'll be in touch soon to verify your account"
        end
      end
    end
  end

  def new_team
  end

  def dashboard
    @team = Team.find(@user.team_id)
    @notification_view_count = @team.team_notifications.where(notification_type: "athlete_profile_view").count
    @interested_athletes_count = AthleteInterest.where(team_id: @team.id).count
  end

  def premium
  end

  def advocare
  end

  def save_athlete
    @user = User.find(params[:user_id])
    athlete = AthleteProfile.find(params[:athlete_profile])
    @user.save_athlete(athlete)

    # Increment count
    saved_athlete_count = current_user.saved_athletes_count
    User.find(current_user.id).update_attributes(saved_athletes_count: saved_athlete_count + 1)

    render :nothing => true
  end

  def unsave_athlete
    @user = User.find(params[:user_id])
    athlete = AthleteProfile.find(params[:athlete_profile])
    @user.unsave_athlete(athlete)
    render :nothing => true
  end

  def saved_athletes
    @user = User.find(params[:id])
    @saved_athletes = @user.saved_athletes.order(:rank_order)
  end

  def sort
    params[:order].each do |key,value|
      SavedAthlete.find(value[:id]).update_attribute(:rank_order,value[:position])
    end
    render :nothing => true
  end

  def view_notifications
    @team = Team.find(@user.team_id)
    if @user.paid_subscription? && (@user.subscription.subscription.subscription_level == 'gold_monthly' || 'gold_annually' || 'platinum_monthly' || 'platinum_annually')
      @profile_notifications = []
      @team_notifications = @team.team_notifications.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
    elsif @user.paid_subscription? && (@user.subscription.subscription_level == 'silver_monthly' || 'silver_annually')
      @profile_notifications = @team.team_notifications.where(notification_type: 1).order("created_at DESC")
      @team_notifications = @team.team_notifications.where.not(notification_type: 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
    else
      @profile_notifications = @team.team_notifications.where(notification_type: 1).order("created_at DESC")
      @team_notifications = @team.team_notifications.where.not(notification_type: 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
    end
  end

  def platinum_subscription
    AdminMailer.platinum_subscription_notification(current_user).deliver_later
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_user_rights
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to root_path, notice: "You don't have access to do that."
    end
  end

  def ensure_team
    unless current_user.team? || current_user.admin?
      redirect_to root_path, notice: "You don't have access to do that."
    end
  end

  def check_saved_athlete_count
    unless current_user.paid_subscription? && (current_user.subscription.subscription_level == "gold_monthly" || current_user.subscription.subscription_level == "gold_annually" || current_user.subscription.subscription_level == "platinum_monthly" || current_user.subscription.subscription_level == "platinum_annually")
      if current_user.paid_subscription? && (current_user.subscription.subscription_level == "silver_monthly" || current_user.subscription.subscription_level == "silver_annually")
        if current_user.saved_athletes_count > 20
          flash[:notice] = "
          <div class='col-sm-6 col-md-offset-4 col-md-4'>
            <div class='list-group-item top-add-on text-center text-uppercase'>
              <span style='font-size: inherit;font-weight: bold; color:#d9534f;'>Your Daily Save Limit Reached</span>
              </div>
            <div class='connector-top thumbnail text-center' style='padding-top: 20px;'>
              <p style='vertical-align: baseline; font-size:18px'>Time to next save</p>
                <h1 style='color:#d9534f; padding-right:1px !important;'>12:01 <small>am</small</h1>
                <p style='vertical-align: baseline; font-size:18px'><br> or <br></p>
                <div class='caption'>

                <a href='#{premium_user_path}' class='btn btn-default btn-success'>Try Premium
                  <span class='label label-danger'> SALE</span>
                </a>
              </div>
            </div>
          </div>
              "
          flash.keep(:notice)
          render :js => "window.location.pathname='#{athlete_profiles_path}'"
        end
      elsif current_user.saved_athletes_count > 3
        flash[:notice] = "
        <div class='col-sm-6 col-md-offset-4 col-md-4'>
            <div class='list-group-item top-add-on text-center text-uppercase'>
              <span style='font-size: inherit;font-weight: bold; color:#d9534f;'>Your Daily Save Limit Reached</span>
            </div>
            <div class='connector-top thumbnail text-center' style='padding-top: 20px;'>
              <p style='vertical-align: baseline; font-size:18px'>Time to next save</p>
              <h1 style='color:#d9534f; padding-right:1px !important;'>12:01 <small>am</small</h1>
              <p style='vertical-align: baseline; font-size:18px'><br> or <br></p>
              <div class='caption'>

                <a href='#{premium_user_path}' class='btn btn-default btn-success'>Try Premium
                  <span class='label label-danger'> SALE</span>
                </a>
              </div>
            </div>
          </div>
        "
        flash.keep(:notice)
        render :js => "window.location.pathname='#{athlete_profiles_path}'"
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:token, :team_id, :first_name, :last_name, :user_type, :email, :password, :password_confirmation, :team_validated)
  end


end