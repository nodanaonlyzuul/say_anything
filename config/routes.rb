Rails.application.routes.draw do
  resources :sayings
  root "sayings#new"
end
