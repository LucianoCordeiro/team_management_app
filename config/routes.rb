Rails.application.routes.draw do
  resources :users, only: [:index, :show]
  resources :teams, only: [:index, :show]
end
