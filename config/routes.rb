# frozen_string_literal: true
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
  resources :albums do
    resources :album_recipients, only: [:create]
  end
  resources :photos do
    patch 'set_cover_photo', on: :member
    collection do
      delete 'multi_delete'
    end
  end
  resources :watermarks
  resources :contacts
  resources :services do
    collection do
      get 'active_services'
    end
  end

  get 'contact_details', to: 'contact_details#show'
  put 'contact_details', to: 'contact_details#update'

  get 'abouts', to: 'abouts#show'
  put 'abouts', to: 'abouts#update'

  resources :services
  resources :testimonials
  resources :homepage_photos do
    collection do
      put 'select_uploaded_photo'
      put 'active_gallery_photo'
      get 'active'
    end
  end
  resources :contact_messages, only: [:create]
  resources :videos
end
