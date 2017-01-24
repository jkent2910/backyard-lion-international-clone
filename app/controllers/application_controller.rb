class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if resource.athlete?
      if resource.athlete_profile.nil?
        :new_athlete_profile
      else
        athlete_profile_path(resource.athlete_profile)
      end
    elsif resource.team?
      if resource.team_id.nil?
        new_team_user_path(resource)
      elsif resource.team? && !resource.team_validated?
        new_team_user_path(resource)
      elsif resource.team? && resource.team_validated?
        dashboard_user_path(resource)
      end

    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  def set_global_search_variable
    @q = Team.search(params[:q])
    @athlete_search = AthleteProfile.ransack(params[:q])
    @team_note_search = AthleteNote.ransack(params[:q])
  end


  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_hash, url: request.url)
  end

end
