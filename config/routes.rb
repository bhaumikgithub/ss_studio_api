Rails.application.routes.draw do
  
  use_doorkeeper do
  	skip_controllers :applications, :authorized_applications
  end

  devise_for :users, controllers: {
      registrations: 'users/registrations',
      passwords: 'user/passwords',
      confirmations: 'user/confirmations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :categories
  resources :albums
  resources :photos
end
