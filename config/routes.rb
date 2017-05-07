Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :urls , only: [:index,:create]
  end
end
