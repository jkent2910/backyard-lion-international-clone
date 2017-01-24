class AthleteRecommendationsController < ApplicationController

  before_filter :cannot_reco_yourself, only: [:new, :create]
  before_filter :can_only_submit_one_reco, only: [:new, :create]
  before_filter :set_athlete_profile, only: [:new, :create, :cannot_reco_yourself, :can_only_submit_one_reco]

  def index
  end

  def show
  end

  def new
    @athlete_recommendation = @athlete_profile.athlete_recommendations.build
  end

  def edit
  end

  def create
    @athlete_recommendation = AthleteRecommendation.new(athlete_recommendation_params)
    respond_to do |format|
      if @athlete_recommendation.save

        # Create athlete_notification
        if @athlete_recommendation.giver_athlete_profile_id.nil?
          AthleteNotification.create!(athlete_profile_id: @athlete_recommendation.athlete_profile_id, notification_type: "recommendation")
        else
          other_user_id = AthleteProfile.find(@athlete_recommendation.giver_athlete_profile_id).user_id
          AthleteNotification.create!(athlete_profile_id: @athlete_recommendation.athlete_profile_id, notification_type: "recommendation", other_user_id: other_user_id)
        end

        # Send notification e-mail to athlete
        NotificationMailer.recommendation_notification(@athlete_recommendation.athlete_profile_id).deliver_later

        format.html { redirect_to athlete_profile_path(@athlete_profile), notice: 'Great! Your recommendation is created.' }
      else
        format.html { render :new }
        format.json { render json: @athlete_recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def athlete_recommendation_params
    params.require(:athlete_recommendation).permit(:athlete_profile_id, :giver_first_name, :giver_last_name,
                                                   :giver_relationship, :giver_athlete_profile_id, :giver_position, :recommendation_text)
  end

  def set_athlete_profile
    @athlete_profile = AthleteProfile.find(params[:athlete_profile_id])
  end

  def cannot_reco_yourself
    if user_signed_in?
      if current_user.id == AthleteProfile.find(params[:athlete_profile_id]).user_id
        @athlete_profile = AthleteProfile.find(params[:athlete_profile_id])
        redirect_to athlete_profile_path(@athlete_profile), notice: "You can't recommendation yourself"
      end
    end

  end

  def can_only_submit_one_reco
    if user_signed_in? && current_user.athlete?
      @athlete_recos = AthleteRecommendation.where("athlete_profile_id = ?", params[:athlete_profile_id])
      if @athlete_recos.where(giver_athlete_profile_id: AthleteProfile.find_by(user_id: current_user.id)).any?
        redirect_to athlete_profile_path(@athlete_profile), notice: "You can only recommendation someone once"
      end
    end
  end
end