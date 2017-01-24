class TeamsController < ApplicationController

  before_action :set_team, only: [:show, :edit, :update, :destroy, :leave_video_comment, :interested_athletes, :team_notes]
  before_action :ensure_team_ownership, only: [:edit, :update, :destroy, :interested_athletes, :team_notes]
  before_action :ensure_admin, only: [:new, :create]
  before_action :check_view_count, only: [:show]
  before_action :authenticate_user!
  before_action :check_for_gold_subscription, only: [:create_new_note, :team_notes]

  def index
    unless params[:q].nil?
      if params[:q][:wanted_positions_position_id_eq].present?
        params[:q][:wanted_positions_position_id_eq].to_i
      end

      params[:q].delete(:looking_games_true) if params[:q][:looking_games_true] = '0'
    end

    @q = Team.ransack(params[:q])
    @teams = @q.result.paginate(:page => params[:page])
  end

  def show
    @team_photos = @team.team_photos
    @wanted_positions = @team.wanted_positions

    if user_signed_in? && current_user.athlete?
      create_team_profile_notification(current_user, @team)
    end

    user = User.find(current_user.id)
    unless user.team_id == @team.id
      current_count = user.team_view_count
      user.update_attributes(team_view_count: current_count + 1)
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    
    respond_to do |format|
      if @team.save

        if params[:images]
          params[:images].each { |image|
            @team.team_photos.create(image: image)
          }
        end

        format.html { redirect_to team_path(@team), notice: 'Team created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @team.update(team_params)

        # Handle photos 
        if params[:images]
          params[:images].each { |image|
            @team.team_photos.create(image: image)
          }
        end

        format.html { redirect_to team_path(@team), notice: "Team updated" }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Team deleted" }
      format.json { head :no_content }
    end
  end

  def remove_wanted_position
    team = Team.find(params[:team_id])
    wanted_position = WantedPosition.where(id: params[:wanted_position_id], team_id: team.id).destroy_all

    render :nothing => true
  end

  def interested_athletes
    @interested_athletes = AthleteInterest.where(team_id: @team.id)
  end

  def leave_video_comment
    TeamVideoComment.create(body: params[:video_comment], team_video_id: params[:team_video_id], user_id: params[:user_id])
    team = Team.find(params[:team_id])

    TeamNotification.create!(team_id: team.id, notification_type: "video_comment", other_user_id: params[:user_id])

    redirect_to team_path(team), notice: "Comment saved!"
  end

  def create_new_note
    AthleteNote.create(note: params[:note_body], team_id: params[:team_id], user_id: params[:user_id], athlete_profile_id: params[:athlete_profile_id])
    team = Team.find(params[:team_id])
    athlete = AthleteProfile.find(params[:athlete_profile_id])
    if params[:location].present?
      redirect_to athlete_profile_path(athlete), notice: "Note saved!"
    else
      redirect_to team_notes_team_path(team), notice: "Note saved!"
    end
  end

  def sort
    params[:order].each do |key,value|
      AthleteInterest.find(value[:id]).update_attribute(:rank_order,value[:position])
    end
    render :nothing => true
  end

  def update_notifications
    @team = Team.find(params[:id])
    @team.team_notifications.map { |n| n.update_attributes( { :viewed => true}) }
    render :nothing => true
  end

  def team_notes

    unless params[:q].nil?
      # Do stuff later
    end
    @team_note_search = AthleteNote.joins(:athlete_profile).where(team_id: @team.id).ransack(params[:q])
    @team_notes = @team_note_search.result.paginate(:page => params[:page])
  end

  def get_teams
    teams = Team.where(country: params[:country])

    respond_to do |format|
      format.json {render json: teams}
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def ensure_team_ownership
    @team = Team.find(params[:id])
    unless user_signed_in? && current_user.admin?
      if current_user.team_id != @team.id || !current_user.team_validated?
        redirect_to root_path, notice: "You are not allowed to perform that action."
      end
    end
  end

  def ensure_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path, notice: "You are not allowed to perform that action."
    end
  end

  def create_team_profile_notification(current_user, team)
    unless TeamNotification.where('team_id = ? AND other_user_id = ? AND notification_type = ?', team.id, current_user.id, 1).any?
      TeamNotification.create!(team_id: team.id, notification_type: "athlete_profile_view", other_user_id: current_user.id)
    end


    if TeamContact.where(team_id: team.id).exists?
      contact = TeamContact.where(team_id: team.id)
      contact.each do |c|
        NotificationMailer.team_view(c.email, c.team_id).deliver_later
      end
    end

  end

  def check_view_count

    if current_user.nil?
      redirect_to root_path, notice: "You must be signed in"
    else
      unless user_signed_in? && current_user.paid_subscription?
        if current_user.team_view_count > 5
          redirect_to teams_path, notice: "
          <div class='col-sm-6 col-md-offset-4 col-md-4'>
            <div class='list-group-item top-add-on text-center text-uppercase'>
              <span style='font-size: inherit;font-weight: bold; color:#d9534f;'>Your Daily Browse Limit Reached</span>
            </div>
            <div class='connector-top thumbnail text-center' style='padding-top: 20px;'>
              <p style='vertical-align: baseline; font-size:18px'>Time to next browse</p>
              <h1 style='color:#d9534f; padding-right:1px !important;'>12:01 <small>am</small</h1>
              <p style='vertical-align: baseline; font-size:18px'><br> or <br></p>
              <div class='caption'>

                <a href='#{premium_user_path}' class='btn btn-default btn-success'>Try Premium
                  <span class='label label-danger'> SALE</span>
                </a>
              </div>
            </div>
          </div>"
        end
      end
    end

  end

  def check_for_gold_subscription
    unless current_user.paid_subscription? && (current_user.subscription.subscription_level == 'gold_monthly' || 'gold_annually' || 'platinum_monthly' || 'platinum_annually')
      redirect_to premium_user_path, notice: "You must purchase a premium subscription to create notes"
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:cover_photo, :sport, :country, :town, :level, :gender, :website, :season, :team_name, :other_benefits, :salary, :looking_games, :looking_for_players, :looking_for_coaches, :additional_info, team_videos_attributes: [:id, :name, :url, :description, :_destroy],
                                 team_benefit_ratings_attributes: [:id, :benefit_id, :benefit_rating, :_destroy], wanted_positions_attributes: [:id, :position_id, :priority, :_destroy])
  end

end