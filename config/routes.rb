Rails.application.routes.draw do

  devise_for :users
  resources :posts do
    member do
      post "like" => "posts#like"
      post "unlike" => "posts#unlike"
      post "fav" => "posts#fav"
      post "unfav" => "posts#unfav"
      post "toggle_flag" => "posts#toggle_flag"
      post "rate" => "posts#rate"
    end
  end
  root "posts#index"
  get "/jquery-1" => "pages#jquery_1"
  get "/jquery-2" => "pages#jquery_2"
  get "/jquery-3" => "pages#jquery_3"
  get "/jquery-4" => "pages#jquery_4"
  get "/jquery-5" => "pages#jquery_5"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
