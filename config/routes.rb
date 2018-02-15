Rails.application.routes.draw do
  get 'doses/new'

  get 'doses/create'

  get 'doses/destroy'

  get 'cocktails/index'

  get 'cocktails/show'

  get 'cocktails/new'

  get 'cocktails/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cocktails, only: [:index, :show, :new, :create]
  resources :cocktails do
    resources :doses, only: [:new, :create, :destroy]

  end
end
