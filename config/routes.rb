Rails.application.routes.draw do
  root  'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'

  match '/change_locale/:locale', to: 'settings#change_locale', via: 'get', as: :change_locale
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :settings, only: [:index]
  match '/update_settings', to: 'settings#update_settings', via: 'post', as: :update_settings
  match '/update_user', to: 'settings#update_user', via: 'patch', as: :update_user
  match '/settings_tab/:tab', to: 'settings#index', via: 'get', as: :settings_tab

  #resources :skills, only: [:index, :new, :create, :edit, :update, :destroy]
  #resources :candidates, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :report_templates do
    get "delete"
  end

  resources :skills, :candidates, :skill_groups do
    get "delete"
    get :autocomplete_skill_name, on: :collection
    get :autocomplete_skill_group_name, on: :collection
  end

  resources :reports, only: [:index, :show]

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
