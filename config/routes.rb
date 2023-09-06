Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :memberships do
      member do
        put :assign_role
        get :find_role
      end
    end
  end
  resources :teams, only: [:index, :show]
  resources :roles, only: [:create] do
    member do
      get :memberships
    end
  end
end
