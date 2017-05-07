Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :urls, only: %i[index create]
  end
end
