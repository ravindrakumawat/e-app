Rails.application.routes.draw do

  root 'businesses#index'
  resources :businesses do
    resources :contact_infos
    resources :social_accounts
    resources :employees
  end
end
