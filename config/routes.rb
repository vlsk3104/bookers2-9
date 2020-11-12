Rails.application.routes.draw do
	root "homes#top"
  get "home/about" => "homes#about"
  get "home/top" => "homes#top"
  get "search" => "search#search"
  devise_for :users
  resources :users, only: [:new,:show,:index,:edit,:update] do 
    resource :relationships ,only: [:create,:destroy]
    get 'follow' => "relationships#follow", as: "follow"
    get "follower" => "relationships#follower", as: "follower"
  end
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :post_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end