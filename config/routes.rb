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
  resources :watermarks
  resources :albums do
    collection do
      get 'portfolio'
      get 'get_album_status_wise'
    end
    member do
      get 'passcode_verification'
      put 'mark_as_submitted'
      get 'get_selected_photos'
      get 'get_commented_photos'
      put 'mark_as_deliverd'
      put 'mark_as_stoped_selection'
      put 'mark_as_shared'
      put 'acivate_album'
    end
    resources :album_recipients, only: [:create, :index, :destroy] do
      collection do
        get 'not_invited_contacts'
        get 'get_admin_album_recipients'
        delete 'reset_admin_recipients'
      end
      post 'resend', on: :member
    end
  end
  resources :photos do
    patch 'set_cover_photo', on: :member
    collection do
      delete 'multi_delete'
    end
    member do
      resources :comments
    end
    put 'mark_as_checked', on: :collection
  end
  resources :contacts do
    get 'import', on: :collection
  end
  resources :services do
    collection do
      get 'active_services'
      get 'service_details'
    end
  end

  get 'contact_details', to: 'contact_details#show'
  patch 'contact_details', to: 'contact_details#update'
  get 'contact_detail', to: 'contact_details#contact_detail'
  post 'contact_details', to: 'contact_details#create'

  get 'abouts', to: 'abouts#show'
  patch 'abouts', to: 'abouts#update'
  get 'about_us', to: 'abouts#about_us_detail'
  post 'abouts', to: 'abouts#create'

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
  resources :videos do
    collection do
      get 'publish'
      patch 'update_position'
    end
  end
  resources :users, only: [:show] do
    member do
      patch 'update_password'
    end
    resources :user_logos, only: [:show,:create,:update]
  end

  get 'get_logo', to: 'user_logos#get_logo'
  resources :service_icons, only: [:index]
end
