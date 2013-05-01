Spree::Core::Engine.routes.append do
  
  get "/email/:subscriber/:email", :to => "emails#show", :as => :read_email
  get "/subscribers" => redirect("/subscribers/new")
  
  get "/subscribe" => "subscribers#subscribe"
  get "/unsubscribe" => "subscribers#unsubscribe"
  get "/resubscribe" => "subscribers#resubscribe"
  
  resources :subscribers, :except => [:index,:edit,:update] do
    member do
#      get :unsubscribe
#      get "/resubscribe" => "subscribers#resubscribe"
    end
  end
  
#    get "/admin/subscribers/unsubscribed", :to = "admin/subscribers#unsubscribed"
  namespace :admin do
    resources :subscribers 
#      get :unsubscribed
#      get :resubscribe,  :on => :member
#      get :unsubscribe,  :on => :member
#    end
  end

#    get "/unsubscribed", :to = "admin/subscribers#unsubscribed"
#    resources :subscribers do 
#      get :unsubscribed
#      get :resubscribe,  :on => :member
#      get :unsubscribe,  :on => :member
#    end
#    resources :emails do
#      get :deliver, :on => :member, :path => 'send'
#    end
#  end

end
