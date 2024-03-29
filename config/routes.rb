Rails.application.routes.draw do
  if Object.const_defined?(:RailsAdmin)
    mount RailsAdmin::Engine => '/admin/rails_admin', as: 'rails_admin'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'home#index'

  resources :users, only: [:show, :edit, :update]  do
    resources :apps
    resource :review_group, only: [:show, :update]
  end
  resources :apps, only: [:show] do
    resource :feedback
  end

  namespace :admin do
    resources :emails, only: [:new, :create]
    resources :review_dates, only: [:new, :create, :show, :index]
    resources :jenkins, only: [:create, :update]
    resources :apps, only: [:create, :update]
    resource :exercise_points, only: [:create]
    resource :students, only: [:show]
    resource :exercises, only: [:show]
    resource :statistics, only: [:show]
    resources :exceptions, only: [:create]

    post ':user_id/block',   controller: :users, action: :block, as: :block_user
    post ':user_id/unblock', controller: :users, action: :unblock, as: :unblock_user

    post 'fixtures/create',     controller: :fixtures, action: :create

    get  ':app_id/app_review', controller: :app_reviews, action: :show, as: :app_review
    post ':app_id/app_review/:points/confirm', controller: :app_reviews, action: :confirm, as: :app_review_confirm
    post ':app_id/app_review/revoke', controller: :app_reviews, action: :revoke, as: :app_review_revoke

    post 'review_dates/:id/confirm', controller: :review_dates, action: :confirm, as: :review_date_confirm
    post 'review_dates/:id/revoke', controller: :review_dates, action: :revoke, as: :review_date_revoke

    post 'apps/:app_id/exercise_points/:points', controller: :app_exercise_points, action: :update, as: :app_exercise_points
  end

  namespace :apiv1, path: 'api-v1', format: true, constraints: { format: 'json' }  do
    post 'ping', controller: :pings, action: :ping
    post 'exercise_results/:app_permalink/:exercise_id', controller: :exercise_results, action: :create
  end
end
