Logistica::Application.routes.draw do
  resources :mrjs

  resources :aggregation_histories

  resources :election_dates

  resources :election_types

  resources :cad_descritors

  resources :dataele_cities

  resources :dataele_places

  resources :dataele_descritors

  resources :survey_processes

  resources :stations

  resources :places

  resources :cities

  resources :zones

  resources :suit_status_changes

  resources :protocols

  resources :suits

  resources :events

  resources :categories
  
  resources :comments #, :only => [:destroy]

  resources :users do
    collection do
      put :update_profile
    end
  end

  resources :contacts do
    resources :notes do
      member do
        post :comment
      end
    end
    member do
      get :confirm_destroy
      get :avatar
      put :favorite
    end
    collection do
      post :print
    end
  end

  resources :preferences do
    collection do
      get :profile
      get :dashboard
      put :update_dashboard
    end
  end

  resources :tasks do
    member do
      put :complete
      post :comment
      post :postpone
    end
    collection do
      get :get_tasks
      get :week
      get :next_week
      get :completed
    end
  end
  # match '/tasks(/:option)' => 'tasks#index'
  
  # match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
  
 
  match '/calendar' => 'calendar#index', :as => :calendar
  match '/summary' => 'home#summary', :as => :summary
  match '/profile' => 'users#profile', :as => :profile
  
  # autocomplete search
  match '/search' => 'home#search', :as => :search
  match '/search/city' => 'home#search_city', :as => :search_city
  match '/search/occupation' => 'home#search_occupation', :as => :search_occupation
  match '/search/weather' => 'home#search_weather', :as => :search_weather
  


  resources :user_sessions, :only => [:new, :create, :destroy]
  resources :home, :only => [:index]

  #resources :vlv do
  #  member do
  #    post :zona
  #  end
  #  collection do
  #    get :zona
  #  end
  #end
  
  match '/ele2012' => 'ele2012#index'
  
  match '/vlv' => 'vlv#index'
  match '/vlv/zona' => 'vlv#zona'
  match '/vlv/municipio' => 'vlv#municipio'

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  #root :to => "home#index"
  root :to => "ele2012#index"

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
