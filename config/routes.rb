Rails.application.routes.draw do
	 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'homes#top'
	get 'homes/about'
	resources :games

	namespace :admins do
		get 'top' => 'homes#top'
	end

	devise_for :admins, controllers: {
		sessions: 'admins/sessions',
		registrations: 'admins/registrations',
		passwords: 'admins/passwords'
    }

    devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: 'users/registrations',
		passwords: 'users/passwords'
    }

    resources :screenshots, only: [:destroy]

    resources :users, only: [:index, :show, :edit, :update, :destroy] do
    	patch 'status_change',on: :member
    	resource :relationships, only: [:create, :destroy]
	  	member do
	      get :follows
	      get :followers
	    end
    end

end
