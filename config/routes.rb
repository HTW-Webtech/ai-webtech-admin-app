Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin/rails_admin', as: 'rails_admin'
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#show'

  resources :users, only: [:show, :edit, :update]  do
    resources :apps, except: [:destroy] do
      resource :logs, only: [:show]
    end
    resources :exercises, except: [:destroy, :update]
  end

  namespace :admin do
    post 'fixtures/create',     controller: :fixtures, action: :create
    post 'fixtures/create_yml', controller: :fixtures, action: :create_yml

    resource :jenkins,     only: [:create]

    get  ':app_id/app_review', controller: :app_reviews, action: :show, as: :app_review
    post ':app_id/app_review/confirm', controller: :app_reviews, action: :confirm, as: :app_review_confirm
    post ':app_id/app_review/revoke', controller: :app_reviews, action: :revoke, as: :app_review_revoke
  end

  namespace :apiv1, path: 'api-v1', format: true, constraints: { format: 'json' }  do
    post 'ping', controller: :pings, action: :ping
    post 'results/:app_name/:exercise_id', controller: :results, action: :create
  end

  # foo
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
