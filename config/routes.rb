Rails.application.routes.draw do
  


 # devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }


  root 'welcomes#index'
  get 'welcomes/contact'

  get 'welcomes/about'
  get 'fb_callback' => 'welcomes#fb_callback'
  resources :post

  post 'create_contact' => 'welcomes#create_contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #devise_scope :user do
  #delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  #end
end
