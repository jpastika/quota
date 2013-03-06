Quota::Application.routes.draw do
  
  get "dashboard" => "dashboard#index", :as => "dashboard"
  get "choose" => "sessions#choose", :as => "choose_account"
  get "switch" => "sessions#switch_account", :as => "switch_account"
  get "signout" => "sessions#destroy", :as => "signout"
  match '/signup', to: 'accounts#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/catalog', to: 'catalog_items#index'
  
  match '/map_test', to: 'static_pages#map_test'
  match '/bridge', to: 'static_pages#bridge'
  match '/documents/choose_template/:id', to: 'documents#choose_template'
  match '/documents/new/:id', to: 'documents#new'
  match '/catalog_items/manufacturers', to: 'catalog_items#manufacturers'
  match '/template_items/reorder', to: 'template_items#reorder'
  match '/document_items/reorder', to: 'document_items#reorder'
  match '/documents/:id/preview', to: 'documents#preview'
  match '/documents/:id/email', to: 'documents#email'
  
  
  resources :accounts
  resources :catalog_items
  resources :catalog_item_children
  resources :contacts do
    resources :phones, :controller => "contact_phones"
    resources :emails, :controller => "contact_emails"
    resources :urls, :controller => "contact_urls"
    resources :addresses, :controller => "contact_addresses"
  end
  resources :companies
  resources :contact_phones
  resources :contact_emails
  resources :contact_addresses
  resources :contact_urls
  resources :catalog, :controller => "catalog_items"
  resources :docs, :controller => "documents"
  resources :documents
  resources :documents_items
  resources :members
  resources :opportunities
  resources :opportunity_contacts
  # resources :quotes
  resources :sales_reps
  resources :sessions, only: [:new, :create, :destroy, :choose]
  resources :templates
  resources :template_items
  resources :users
  
  scope "api" do
    match '/opportunities/:id/docs', to: 'documents#index'
    match '/account', to: 'accounts#show'
    match '/member', to: 'members#show'
    match '/user', to: 'users#show'
    # match '/contacts/:id/phones', to: 'contact_phones#index'
    match '/companies', to: 'contacts#companies'
    match '/companies/:id/contacts', to: 'companies#contacts'
    match '/companies/filter_by_name', to: 'contacts#filter_companies_by_name'
    match '/manufacturers', to: 'catalog_items#manufacturers'
    match '/catalog_items/filter_by_name_or_part_number', to: 'catalog_items#filter_by_name_or_part_number'
    match '/template_items/reorder', to: 'template_items#reorder'
    match '/templates/filter_by_name_or_item', to: 'templates#filter_by_name_or_item'
    match '/document_items/reorder', to: 'document_items#reorder'
    
    resources :accounts
    resources :catalog_items
    resources :catalog_item_children
    resources :contacts do
      resources :phones, :controller => "contact_phones"
      resources :emails, :controller => "contact_emails"
      resources :urls, :controller => "contact_urls"
      resources :addresses, :controller => "contact_addresses"
    end
    resources :companies
    resources :contact_types
    resources :contact_phones
    resources :contact_emails
    resources :contact_addresses
    resources :contact_urls
    resources :docs, :controller => "documents"
    resources :catalog, :controller => "catalog_items"
    resources :documents
    resources :document_items
    resources :members
    resources :milestones
    resources :opportunities
    resources :opportunity_contacts
    resources :sales_reps
    resources :templates
    resources :template_items
    resources :users
  end
  
  
  
  root to: 'sessions#new'
  # root to: 'static_pages#home'
  
  
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
  # match ':controller(/:action(/:id))(.:format)'
end
