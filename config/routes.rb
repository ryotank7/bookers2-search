Rails.application.routes.draw do
  root to:'home_#index'
  get 'home/about'
  devise_for :users
  resources :users do
  	member do
  		get :following, :followers
  	end
  end
    resources :books do
    	resource :book_comments, only:[:create, :destroy]
    	resource :favorites, only:[:create, :destroy]
    end
    resources :relationships, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

