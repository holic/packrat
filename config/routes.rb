Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :projects do
    resources :updates
  end

  resources :updates

  root "projects#index"
end
