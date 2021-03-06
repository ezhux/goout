ActionController::Routing::Routes.draw do |map|

  map.resources :user_sessions
  map.resources :roles

  map.resources :concepts, :as => "wiki"
  map.resources :concepts do |concept|
    concept.resources :revisions
  end

  map.resources :subject_areas do |area|
      area.resources :study_programs
  end
  
  map.resources :activity_areas
  map.resources :friendships
  map.resources :exchange_programs
  map.resources :organizations
  map.resources :study_programs
  map.resources :countries

  map.resources :questions do |question|
    question.resources :answers
  end

  map.resources :users  do |user|
    user.resources :activities
    user.resources :tags do |tag|
      tag.resources :posts
    end
    user.resources :posts do |post|
      post.resources :comments do |comment|
        comment.resources :comments, :as => "replies"
      end
    end
  end

  
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

   map.root :controller => "site"

   map.zeitgeist "zeitgeist/:tag", :controller => "zeitgeist", :action => "index"
   map.login "login", :controller => "user_sessions", :action => "new"
   map.logout "logout", :controller => "user_sessions", :action => "destroy"

   map.user_profile 'user/:user', :controller => 'users', :action => 'show'
   map.blog 'user/:user/blog', :controller => 'posts', :action => 'index'
   map.post 'user/:user/blog/:id', :controller => 'posts', :action => 'show', :id => ''
   map.list 'list/:category', :controller => 'concepts', :action => 'list'
   map.page 'wiki/show/:id', :controller => 'concepts', :action => 'show'
   map.admin 'admin', :controller => 'admin', :action => 'index'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
