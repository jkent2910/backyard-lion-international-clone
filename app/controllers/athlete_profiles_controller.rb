class AthleteProfilesController < ApplicationController

  include AgeHelper

  before_action :set_athlete_profile, only: [:show, :edit, :update, :destroy, :endorse_skill, :remove_skill_endorsement, :saved_teams, :view_notifications]
  before_action :check_for_existing_profile, only: [:new, :create]
  before_action :ensure_athlete_ownership, only: [:edit, :update, :destroy, :view_notifications, :saved_teams]
  skip_before_action :verify_authenticity_token, only: [:express_interest, :register_star_rating, :check_ratings, :update_notifications]
  after_action :set_athlete_height_and_age, only: [:update, :create]
  before_action :check_view_count, only: [:show]
  before_action :check_interest_count, only: [:express_interest, :remove_interest]
  before_action :authenticate_user!
  after_action :calculate_profile_strength, only: [:update, :create]


  def index

    unless params[:q].nil?
      params[:q].delete(:passport_ready_true) if params[:q][:passport_ready_true] == '0'
      params[:q].delete(:actively_looking_true) if params[:q][:actively_looking_true] == '0'
      params[:q].delete(:references_available_true) if params[:q][:references_available_true] == '0'
      params[:q].delete(:coaching_experience_true) if params[:q][:coaching_experience_true] == '0'
    end

    @athlete_search = AthleteProfile.ransack(params[:q])

    @athlete_profiles = @athlete_search.result.paginate(:page => params[:page])

  end

  def show
    @athlete_photos = @athlete_profile.athlete_photos
    @athlete_experiences = @athlete_profile.athlete_experiences
    @athlete_videos = @athlete_profile.athlete_videos
    @athlete_recommendations = @athlete_profile.athlete_recommendations
    @athlete_skills = @athlete_profile.athlete_skills

    if user_signed_in? && current_user.id != @athlete_profile.user_id && !current_user.admin?
      if current_user.team? || current_user.team_id != nil
        create_team_profile_notification(current_user, @athlete_profile)
      elsif current_user.athlete?
        create_athlete_profile_notification(current_user, @athlete_profile)
      end

      # Send notification e-mail to athlete
      NotificationMailer.profile_view_notification(@athlete_profile).deliver_later

      # Don't increase view count if you're on your own profile
      unless current_user.id == @athlete_profile.user_id
        user = User.find(current_user.id)
        current_count = user.athlete_view_count
        user.update_attributes(athlete_view_count: current_count + 1)
      end

    end
  end

  def new
    @athlete_profile = AthleteProfile.new
  end

  def create
    @athlete_profile = AthleteProfile.new(athlete_profile_params)
    @athlete_profile.user = current_user


    respond_to do |format|
      if @athlete_profile.save

        # Send e-mail to Devan & Julie
        AdminMailer.new_athlete_profile(@athlete_profile).deliver_later

        format.html { redirect_to teams_path, notice: "NEXT STEP: Let us know where you want to play" }
        format.json { render :show, status: :created, location: @athlete_profile }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @athlete_profile.update(athlete_profile_params)

        if params[:images]
          params[:images].each { |image|
            @athlete_profile.athlete_photos.create(image: image)
          }
        end

        format.html { redirect_to athlete_profile_path(@athlete_profile), notice: "Athlete profile updated" }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @athlete_profile.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Your athlete profile has been deleted.' }
      format.json { head :no_content }
    end
  end

  def remove_interest
    team = Team.find(params[:team_id])
    @athlete_profile = AthleteProfile.find(params[:athlete_profile])
    @athlete_profile.remove_interest(team.id)
    render :nothing => true
  end

  def express_interest
    team = Team.find(params[:team_id])
    @athlete_profile = AthleteProfile.find(params[:athlete_profile])
    @athlete_profile.express_interest(team.id, current_user.id)

    # Increment count
    express_interest_count = @athlete_profile.express_interest_count
    @athlete_profile.update_attributes(express_interest_count: express_interest_count + 1)

    render :nothing => true
  end

  def remove_skill_endorsement
    skill = AthleteSkill.find(params[:skill_id])
    endorser = AthleteProfile.find(params[:endorser_id])
    @athlete_profile.remove_skill_endorsement(skill, endorser)

    redirect_to athlete_profile_path(@athlete_profile)
  end

  def endorse_skill
    skill = AthleteSkill.find(params[:skill_id])
    endorser = AthleteProfile.find(params[:endorser_id])
    user_id = endorser.user_id
    @athlete_profile.endorse_skill(skill, endorser)

    # Create athlete_notification
    AthleteNotification.create!(athlete_profile_id: @athlete_profile.id, notification_type: "skill_endorsement", other_user_id: user_id)

    # Send notification e-mail to athlete
    NotificationMailer.skill_endorsement_notification(@athlete_profile).deliver_later

    redirect_to athlete_profile_path(@athlete_profile)
  end

  def register_star_rating
    if AthleteRating.where('rater_id = ? AND athlete_profile_id = ?', params[:user_id], params[:id]).exists?
      delete_ratings = AthleteRating.where('rater_id = ? AND athlete_profile_id = ?', params[:user_id], params[:id]).destroy_all
      rating = AthleteRating.create(rater_id: params[:user_id], rating: params[:rating], athlete_profile_id: params[:id])
    else
      rating = AthleteRating.create(rater_id: params[:user_id], rating: params[:rating], athlete_profile_id: params[:id])

    end

    # Create athlete_notification
    AthleteNotification.create!(athlete_profile_id: params[:id], notification_type: "rating", other_user_id: params[:user_id])

    # Find athlete
    @athlete_profile = AthleteProfile.find(params[:id])

    unless @athlete_profile.nil?
      # Send notification e-mail to athlete
      NotificationMailer.rating_notification(@athlete_profile).deliver_later
    end

    render :nothing => true
  end

  def check_ratings
    athlete_profile = AthleteProfile.find(params[:athlete_profile])
    rating = AthleteRating.find_by(rater_id: params[:user_id], athlete_profile_id: params[:athlete_profile])
    new_rating = 0
    unless rating.nil?
      new_rating = rating.rating
    end

    respond_to do |format|
      format.json { render json: new_rating }
    end
  end

  def leave_video_comment
    AthleteVideoComment.create(body: params[:video_comment], athlete_video_id: params[:athlete_video_id], user_id: params[:user_id])
    athlete = AthleteProfile.find(params[:athlete_profile_id])

    # Create athlete_notification
    AthleteNotification.create!(athlete_profile_id: params[:athlete_profile_id], notification_type: "video_comment", other_user_id: params[:user_id])

    # Send notification e-mail to athlete
    NotificationMailer.video_comment_notification(@athlete_profile).deliver_later

    redirect_to athlete_profile_path(athlete), notice: "Comment saved!"
  end

  def saved_teams
    @saved_teams = @athlete_profile.athlete_interests.order(:rank_order)
  end

  def update_notifications
    @athlete_profile = AthleteProfile.find(params[:id])
    @athlete_profile.athlete_notifications.map { |n| n.update_attributes({:viewed => true}) }
    render :nothing => true
  end

  def view_notifications
    user = User.find(@athlete_profile.user_id)
    if user.paid_subscription? && (user.subscription.subscription_level == 'gold_monthly' || 'gold_annually' || 'platinum_monthly' || 'platinum_annually')
      @profile_notifications = []
      @athlete_notifications = @athlete_profile.athlete_notifications.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
    elsif user.paid_subscription? && (user.subscription_level == 'silver_monthly' || 'silver_annually')
      @profile_notifications = @athlete_profile.athlete_notifications.where('notification_type = ? OR notification_type = ?', 1, 2).order("created_at DESC")
      @athlete_notifications = @athlete_profile.athlete_notifications.where('notification_type != ? AND notification_type != ?', 1, 2).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
    else
      @profile_notifications = @athlete_profile.athlete_notifications.where('notification_type = ? OR notification_type = ?', 1, 2).order("created_at DESC")
      @athlete_notifications = @athlete_profile.athlete_notifications.where('notification_type != ? AND notification_type != ?', 1, 2).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
    end
  end

  def destroy
    @athlete_profile = AthleteProfile.find(params[:id])
    @athlete_profile.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Profile deleted" }
      format.json { head :no_content }
    end
  end

  def account_settings
    @athlete_profile = AthleteProfile.find(params[:id])
    @user = User.find(@athlete_profile.user_id)
  end

  def calculate_profile_strength
    count = 0
    total = 75
    @athlete_profile.attributes.each do |key, value|
      unless value.blank?
        count = count + 1
      end
    end

    # Check experience
    unless @athlete_profile.athlete_experiences.empty?
      experience = @athlete_profile.athlete_experiences.first
      experience.attributes.each do |key, value|
        unless value.blank?
          count = count + 1
        end
      end
    end

    profile_strength_profile_attributes = ((count.to_f / total.to_f) * 100)

    @athlete_profile.update_attributes(profile_strength: profile_strength_profile_attributes)
  end

  private

  def set_athlete_profile
    @athlete_profile = AthleteProfile.find(params[:id])
  end


  def set_athlete_height_and_age
    @athlete_profile.update_attributes(athlete_height: @athlete_profile.height_feet + (@athlete_profile.height_inches.to_f / 10.to_f),
                                       age: age(@athlete_profile.birthday))
  end

  def check_for_existing_profile
    if user_signed_in? && !current_user.athlete_profile.nil?
      redirect_to current_user.athlete_profile, notice: "You've already created a profile"
    end
  end

  def ensure_athlete_ownership
    if current_user != AthleteProfile.find(params[:id]).user
      redirect_to root_path, notice: "You aren't allowed to perform that action"
    end
  end

  def create_athlete_profile_notification(current_user, athlete_profile)
    unless AthleteNotification.where('athlete_profile_id = ? AND other_user_id = ? AND notification_type = ?', athlete_profile.id, current_user.id, 2).any?
      AthleteNotification.create!(athlete_profile_id: athlete_profile.id, notification_type: "athlete_profile_view", other_user_id: current_user.id)
    end
  end

  def create_team_profile_notification(current_user, athlete_profile)
    unless AthleteNotification.where('athlete_profile_id = ? AND other_user_id = ? AND notification_type = ?', athlete_profile.id, current_user.id, 1).any?
      AthleteNotification.create!(athlete_profile_id: athlete_profile.id, notification_type: "team_profile_view", other_user_id: current_user.id)
    end
  end

  def check_view_count
    if current_user.nil?
      redirect_to root_path, notice: "You must be signed in"
    else
      unless user_signed_in? && (current_user.paid_subscription? || current_user.athlete?)
        if current_user.athlete_view_count > 0
          redirect_to athlete_profiles_path, notice: "
            <div class='col-sm-6 col-md-offset-4 col-md-4'>
              <div class='list-group-item top-add-on text-center text-uppercase'>
                <span style='font-size: inherit;font-weight: bold; color:#d9534f;'>Your Daily View Limit Reached</span>
              </div>
              <div class='connector-top thumbnail text-center' style='padding-top: 20px;'>
                <h1 style='color:#d9534f; padding-right:1px !important;'>12:01 <small>am</small</h1>
                <p style='vertical-align: baseline; font-size:18px'>  will reset <br><br> or <br></p>
                <div class='caption'>

                  <a href='#{premium_user_path}' class='btn btn-default btn-success'>Try Premium
                    <span class='label label-danger'> SALE</span>
                  </a>
                </div>
              </div>
            </div>

            "
        end
      end
    end
  end

  def check_interest_count
    if current_user.nil?
      redirect_to root_path, notice: "You must be signed in"
    else
      unless current_user.paid_subscription?
        if current_user.athlete_profile.express_interest_count > 3
          flash[:notice] = "
          <div class='col-sm-6 col-md-offset-4 col-md-4'>
            <div class='list-group-item top-add-on text-center text-uppercase'>
              <span style='font-size: inherit;font-weight: bold; color:#d9534f;'>Your Daily Submit Limit Reached</span>
            </div>
            <div class='connector-top thumbnail text-center' style='padding-top: 20px;'>
              <h1 style='color:#d9534f; padding-right:1px !important;'>12:01 <small>am</small</h1>
              <p style='vertical-align: baseline; font-size:18px'>  will reset <br><br> or <br></p>
              <div class='caption'>

                <a href='#{premium_user_path}' class='btn btn-default btn-success'>Try Premium
                  <span class='label label-danger'> SALE</span>
                </a>
              </div>
            </div>
          </div>

          "
          flash.keep(:notice)
          render :js => "window.location.pathname='#{teams_path}'"
        end
      end
    end
  end


  def athlete_profile_params
    params.require(:athlete_profile).permit(:profile_picture, :gender, :first_language, :second_language, :third_language, :birthday, :height_feet, :player_interest, :coach_interest,
                                            :height_inches, :age, :athlete_height, :weight, :primary_citizenship, :secondary_citizenship, :passport_ready, :references_available, :agent_used, :coaching_experience, :actively_looking,
                                            :desired_salary, :other_benefits, :resume, athlete_experiences_attributes: [:id, :primary_position, :secondary_position, :team_name, :level, :sport, :start_date, :end_date, :present, :description, :_destroy],
                                            athlete_videos_attributes: [:id, :name, :url, :description, :_destroy], benefit_ratings_attributes: [:id, :benefit_id, :benefit_rating],
                                            athlete_skills_attributes: [:id, :name, :units, :result, :_destroy], athlete_coaches_attributes: [:id, :name, :title, :email, :phone, :school, :_destroy])
  end

end