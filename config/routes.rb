Rails.application.routes.draw do
	 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'homes#top'
	get 'homes/about'
	get 'search' => 'search#search'
	resources :contacts, only: [:new, :create]
	resources :chats, only: [:index, :show, :edit, :create, :update, :destroy] do
		collection do
			get 'talk_room/:id' => 'chats#talk_room', as: 'talk_room'
		end
	end
	resources :games do
		resource :screenshots, only: [:create, :edit, :update, :destroy]
		resource :comments, only: [:create, :destroy]
		get 'more_game', on: :collection
		get 'download', on: :member
	end

	namespace :admins do
		get 'top' => 'homes#top'
		get 'search' => 'search#search'
		resources :contacts, only: [:index, :show, :update]
		resources :chats, only: [:index, :edit, :update, :destroy] do
			collection do
				get 'talk_room/:id' => 'chats#talk_room', as: 'talk_room'
			end
		end
		resources :users, only: [:index, :show, :edit, :update, :destroy] do
			member do
			  patch :status_change
		      get :follow
		      get :follower
		    end
		end
		resources :games, only: [:index, :show, :edit, :update, :destroy] do
			resource :screenshots, only: [:create, :edit, :update, :destroy]
			resource :comments, only: [:destroy]
			get 'download', on: :member
		end
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

    resources :users, only: [:index, :show, :edit, :update, :destroy] do
    	patch 'status_change',on: :member
    	resource :relationships, only: [:create, :destroy]
	  	member do
	      get :follow
	      get :follower
	    end
    end

end
