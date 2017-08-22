# frozen_string_literal: true
Rails.application.routes.draw do
  

  get 'users/show'

  use_doorkeeper do
  	skip_controllers :applications, :authorized_applications
  end

  devise_for :users, controllers: {
      registrations: 'users/registrations',
      passwords: 'user/passwords',
      confirmations: 'user/confirmations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :categories do
    get 'active', on: :collection
  end
  resources :albums do
    collection do
      get 'portfolio'
    end
    resources :album_recipients, only: [:create, :index, :destroy] do
        post 'resend', on: :member
    end
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
  patch 'contact_details', to: 'contact_details#update'

  get 'abouts', to: 'abouts#show'
  patch 'abouts', to: 'abouts#update'

  resources :services
  resources :testimonials do
    collection do
      get 'active'
    end
  end
  resources :homepage_photos do
    collection do
      patch 'select_uploaded_photo'
      patch 'active_gallery_photo'
      get 'active'
    end
  end
  resources :contact_messages, only: [:create]
  resources :videos
  resources :users, only: [:show]
  resources :service_icons, only: [:index]
end
