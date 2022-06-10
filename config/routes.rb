Rails.application.routes.draw do
  resources :students, only: [:index, :show, :update, :destroy, :create]
  resources :instructors, only: [:index, :show, :update, :destroy, :create]
end
