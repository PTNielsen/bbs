Rails.application.routes.draw do
  devise_for :users

  resources :boards do
    resources :posts do
      resources :comments
    end
  end
end
