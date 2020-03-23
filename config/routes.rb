Rails.application.routes.draw do
  root to: 'users#top'
  resource :sign_up, only: %i[create]
  resource :sign_in, only: %i[create]
  resources :users, only: %i[update destroy show] do
    member do
      resources :measures_index, only: %i[index]
      resources :scores_index, only: %i[index]
      resources :routines_index, only: %i[index]
    end
  end
  resource :routine_scores, only: %i[create]
  resources :routines, only: %i[create update destroy show] do
    member do
      resources :routine_exercises, only: %i[create destroy], param: :routine_exercise_id
    end
  end
  resources :measures, only: %i[create destroy update]
  resources :scores, only: %i[destroy update]
  resources :exercises, only: %i[create index update destroy] do
    member do
      resource :score, only: %i[create]
    end
  end
end

# users member
# resource :follow, only: [:create, :destroy]
# get :followings
# get :followers

# 
# get 'my_follow_requests', to: 'follow_requests#my_requests'
# delete 'my_follow_requests/:id', to: 'follow_requests#my_request_cancel'
# resources :follow_requests, only: [:update, :destroy, :index] 
