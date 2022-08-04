Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      match 'webhooks' => 'webhooks#index', via: [:get, :post]
      resources :cards
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '*path', to: 'pages#index'
  root 'pages#index', as: :pages_index
end
