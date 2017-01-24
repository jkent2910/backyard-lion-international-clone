Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations", sessions: 'sessions' }

  root 'welcome#index'

  resources :athlete_profiles do
    resources :athlete_recommendations
    member do
      get :saved_teams
      get :account_settings
      post :remove_interest
      post :express_interest
      post :register_star_rating
      post :check_ratings
      get :endorse_skill
      get :remove_skill_endorsement
      post :leave_video_comment
      get :view_notifications
    end
  end

  post '/athlete_profiles/update_notifications' => 'athlete_profiles#update_notifications'
  post '/teams/update_notifications' => 'teams#update_notifications'
  get '/users/premium' => 'users#premium', as: 'premium_user'
  get '/users/advocare' => 'users#advocare', as: 'advocare_user'
  get '/platinum_subscription' => 'users#platinum_subscription', as: 'platinum_subscription'

  resources :teams do
    member do
      post :leave_video_comment
      get :interested_athletes
      get :team_notes
      post :create_new_note
      patch :remove_wanted_position
    end

    put :sort, on: :collection
    post :get_teams, on: :collection
  end

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
      get :render_conversation
      get :render_message_modal
    end

    collection do
      delete :empty_trash
    end
  end

  # These are for the JS parts of the message logic
  get '/conversations/render_new_message' => 'conversations#render_new_message', as: 'render_new_message'

  resources :messages, only: [:new, :create]

  resources :users do
    put :sort, on: :collection
    member do
      post :save_athlete
      post :unsave_athlete
      get :saved_athletes
      get :dashboard
      get :new_team
      get :view_notifications
    end
  end

  resources :subscriptions
end
