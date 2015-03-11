MobileSurf::Application.routes.draw do
  resources :regions

  resources :profiles

  resources :stations

  get "buoy_map/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
  root :to => 'main#index'
  
  # match 'products/:id', :to => 'catalog#view'
    
  get 'region/:region', :to => 'main#region'
  get 'region-id/:id', :to => 'main#region'  
  get 'regions', :to => 'main#regions'
  
  get 'forcast/:region', :to => 'main#forcast'
  
  get 'prof/:name(.:format)', :to => 'main#show_profile'
  get 'prof-id/:id', :to => 'main#show_profile_by_id'
  
   
  get 'profmodel/:name', :to => 'main#show_surfcast'
   
  get 'buoymodel/:station', :to => 'main#show_full_surfcast'
  get 'weather/:name', :to => 'weather#show_weather'
  get 'tides/:name', :to => 'weather#show_tides'
  
  get 'weather/index'
  get 'adminbase/login'
  get 'profile_admin/index'
  get 'profile_admin/new'
  get 'profile_admin/list'
  get 'profile_admin/show'
  get 'profile_admin/edit'
  get 'profile_admin/destroy'
  get 'profile_admin/add_buoys'
  post 'profile_admin/update_add_buoys'
  
  post 'profile_admin/update'


  post 'profile_admin/create'
  
  get 'station_admin/index'
  get 'station_admin/new'
  
  get 'station_admin/show'
  get 'station_admin/edit'
  get 'station_admin/destroy'

  post 'station_admin/create'

  get 'station_admin/list'
  post 'station_admin/update'
  
  get "main/regions"
  get "main/region"
  get "main/reports"
  post 'adminbase/authorize'
  
  get "buoy_map/show_map"
  
  get "/index2", to: "main#index2"
  get "/admin", to: "admin#index"
  get "/buoy-data.json", to: "station_admin#index"
  
  get "/data", to: "main#data"
  
  # Install the default route as the lowest priority.
#  map.connect ':controller/:action/:id.:format'
#  map.connect ':controller/:action/:id'
  
  
end
