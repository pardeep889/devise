Rails.application.routes.draw do
 # devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }


  root 'welcomes#index'
  get 'welcomes/contact'

  get 'welcomes/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
