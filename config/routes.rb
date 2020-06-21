Rails.application.routes.draw do
  #admins
  devise_for :admins, :controllers => {
  	:sessions => 'admins/sessions'
  }

  #users
  devise_for :users, :controllers => {
  	:registrations => 'users/registrations',
  	:sessions => 'users/sessions',
  	:passwords => 'users/passwords'
  }

  #admin
  namespace :admin do
  	get 'top' => 'homes#top'
  	resources :users, only: [:index, :show, :edit, :update] do
  	   resources :diaries, only: [:index, :show, :destroy]
    end
    resources :contacts, only: [:index, :edit, :update]
  end

  #user
  scope module: :user do
  	root 'homes#top'
  	get 'homes/about'
  	resources :diaries do
  		resources :diary_comments, only: [:create, :destroy]
  		resource :favorites, only: [:create, :destroy]
  	end
  	resources :users, only: [:show, :edit, :update] do
  		resource :relationships, only: [:create, :destroy]
  		get 'follows' => 'relationships#follower', as: 'follows'
  		get 'followers' => 'relationships#followed', as: 'followers'
  	end
  	get 'leave' => 'users#leave'
  	get 'hide' => 'users#hide'
    resources :rooms, only: [:create, :show]
  	resources :chats, only: [:create]
  	resources :contacts, only: [:new, :create]
  	get 'contacts/thanks' => 'contacts#thanks'
  	get 'search' => 'search#search'
    resources :notifications, only: [:index]
  end

  if Rails.env.development?
     mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
