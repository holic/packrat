Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :projects do
    member do
      get 'follow'
      get 'unfollow'
    end
    resources :updates
  end

  resources :updates

  root "projects#index"

  post "/session", to: "session#create"

end
