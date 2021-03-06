Rails.application.routes.draw do
  scope '/v1' do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :events, except: [:new, :edit]
    get 'games' => 'games#all_games'
    get 'games/:game_id' => 'games#show_game'
    get 'players/:bat_id/batting/:event_type' => 'events#show_batter_events'
    get 'players/:pit_id/pitching/:event_type' => 'events#show_pitcher_events'
    get 'players/search/:player' => 'players#search'
    get 'players/:player_id' => 'players#show'
    get 'players/:player_id/:request_type' => 'players#bad_request'
    get 'players' => 'players#index'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
