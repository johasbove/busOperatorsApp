Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :bus_operators, concerns: :paginatable do
    resources :reviews, shallow: true, only: :index, concerns: :paginatable
  end

  root to: 'bus_operators#index'
end
