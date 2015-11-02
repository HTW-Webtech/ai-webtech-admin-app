Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin/rails_admin', as: 'rails_admin'
  devise_for :users

  root 'admin/status#show'

  resources :users, only: [:show, :edit, :update]  do
    resources :apps, except: [:destroy] do
      resources :logs, only: [:index, :show]
    end
  end

  namespace :admin do
    post 'fixtures/create',     controller: :fixtures, action: :create
    post 'fixtures/create_yml', controller: :fixtures, action: :create_yml

    resource :jenkins, only: [:create]

    get  ':app_id/app_review', controller: :app_reviews, action: :show, as: :app_review
    post ':app_id/app_review/confirm', controller: :app_reviews, action: :confirm, as: :app_review_confirm
    post ':app_id/app_review/revoke', controller: :app_reviews, action: :revoke, as: :app_review_revoke
  end

  namespace :apiv1, path: 'api-v1', format: true, constraints: { format: 'json' }  do
    post 'ping', controller: :pings, action: :ping
    post 'exercise_results/:app_name/:exercise_id', controller: :exercise_results, action: :create
  end
end
